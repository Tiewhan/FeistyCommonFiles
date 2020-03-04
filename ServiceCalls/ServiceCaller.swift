//
//  ServiceCaller.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/04.
//

import Foundation

public enum ServiceCallError: Error {
  case noDataAvailable
  case generalError
  case malformedRequest
}

public struct ServiceCaller {
  
  public func makeServiceCall(with url: URL,
                              callSucceeded: @escaping((Data) -> Void),
                              callFailed: @escaping((ServiceCallError) -> Void)) {
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

      if error != nil {
        
        callFailed(.generalError)
        return
        
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        
        callFailed(.malformedRequest)
        return
        
      }

      if let data = data {
        callSucceeded(data)
      } else {
        callFailed(.noDataAvailable)
      }
      
    }
    
    task.resume()
      
  }
  
}
