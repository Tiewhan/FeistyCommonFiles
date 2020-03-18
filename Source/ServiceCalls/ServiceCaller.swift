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

public class ServiceCaller {
  
  public var callSucceeded: ((Data, DataBundle) -> Void)?
  public var callFailed: ((ServiceCallError) -> Void)?
  
  public func makeServiceCall(with url: URL, and dataBundle: DataBundle) throws {
    
    try checkIfCallerIsSetUp()
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

      if error != nil {
        
        self.callFailed?(.generalError)
        return
        
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        
        self.callFailed?(.malformedRequest)
        return
        
      }

      if let data = data {
        self.callSucceeded?(data, dataBundle)
      } else {
        self.callFailed?(.noDataAvailable)
      }
      
    }
    
    task.resume()
      
  }
  
  private func checkIfCallerIsSetUp() throws {
    
    guard callSucceeded != nil else {
      throw SerivceCallerSetupError.noCallSucceededCallback
    }
    
    guard callFailed != nil else {
      throw SerivceCallerSetupError.noCallFailedCallback
    }
    
  }
  
  public func resetCaller() {
    
    callSucceeded = nil
    callFailed = nil
    
  }
  
}
