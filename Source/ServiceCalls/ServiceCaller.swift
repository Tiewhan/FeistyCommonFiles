//
//  ServiceCaller.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/04.
//

import Foundation

public enum ServiceCallError: Error, Equatable {
  case noDataAvailable
  case generalError
  case malformedRequest
}

public enum SerivceCallerSetupError: Error, Equatable {
  case noCallSucceededCallback
  case noCallFailedCallback
}

public struct ServiceCallerDataBundleKeys {
  static let postParameters: String = "parameters"
}

public class ServiceCaller {
  
  public var callSucceeded: ((Data, DataBundle) -> Void)?
  public var callFailed: ((ServiceCallError) -> Void)?
  public var callFailedWithData: ((ServiceCallError, DataBundle) -> Void)?
  
  public func makeServiceCall(with url: URL,
                              and dataBundle: DataBundle,
                              usingMethod method: String = "GET") throws {
    
    try checkIfCallerIsSetUp()
    
    let request = setUpRequest(withURL: url, andWithMethod: method, andWithData: dataBundle)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

      if error != nil {
        
        self.callFailed?(.generalError)
        self.callFailedWithData?(.generalError, dataBundle)
        return
        
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        
        self.callFailed?(.malformedRequest)
        self.callFailedWithData?(.malformedRequest, dataBundle)
        return
        
      }

      if let data = data {
        self.callSucceeded?(data, dataBundle)
      } else {
        self.callFailed?(.noDataAvailable)
        self.callFailedWithData?(.noDataAvailable, dataBundle)
      }
      
    }
    
    task.resume()
      
  }
  
  private func setUpRequest(withURL url: URL,
                            andWithMethod method: String,
                            andWithData data: DataBundle) -> URLRequest {
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if method == "POST" {
      post(request: &request, andWithData: data)
    }
    
    return request
    
  }
  
  private func post(request: inout URLRequest,
                    andWithData data: DataBundle) {
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let parameters: [String: Any] = data.extraData[ServiceCallerDataBundleKeys.postParameters]
                                    as? [String: Any] ?? [:]
    data.extraData.removeValue(forKey: ServiceCallerDataBundleKeys.postParameters)
    
    request.httpBody = parameters.percentEncoded()
    
  }
  
  private func checkIfCallerIsSetUp() throws {
    
    guard callSucceeded != nil else {
      throw SerivceCallerSetupError.noCallSucceededCallback
    }
    
    guard (callFailed != nil) || (callFailedWithData != nil) else {
      throw SerivceCallerSetupError.noCallFailedCallback
    }
    
  }
  
  public func resetCaller() {
    
    callSucceeded = nil
    callFailed = nil
    callFailedWithData = nil
    
  }
  
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
