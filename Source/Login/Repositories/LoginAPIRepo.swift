//
//  LoginAPIRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public class LoginAPIRepo {

  struct JSONLoginResult: Codable {
    let can_login: Bool
  }

  struct DataBundleKeys {
    static let loginUsername: String = "username"
    static let loginPassowrd: String = "password"
  }
  
  public weak var observer: LoginRepositoryObserver?
  
  public init() { }
  
  private func decodeLoginResult(from data: Data) -> Bool {
    
    if let loginResult = try? JSONDecoder().decode(JSONLoginResult.self, from: data) {
      return loginResult.can_login
    }
    
    return false
  }
  
}

extension LoginAPIRepo: LoginRepositoryType {
  
  public func attemptLogin(withUsername username: String,
                           andPassword password: String,
                           using serviceCaller: ServiceCaller) {
    
    guard let url = URL(string: FeistyAPIURLComponents.loginURL) else {
      return
    }
    
    let dataBundle = DataBundle()
    
    var loginParamters: [String: Any] = [:]
    loginParamters[DataBundleKeys.loginUsername] = username
    loginParamters[DataBundleKeys.loginPassowrd] = password
    
    dataBundle.extraData[ServiceCallerDataBundleKeys.postParameters] = loginParamters
    
    serviceCaller.callFailed = { _ in
      self.observer?.authenticationAttemptFinished(withResult: false)
    }
    
    serviceCaller.callSucceeded = { data, dataBundle in
      
      let result = self.decodeLoginResult(from: data)
      self.observer?.authenticationAttemptFinished(withResult: result)
      
    }
    
    do {
      try serviceCaller.makeServiceCall(with: url, and: dataBundle, usingMethod: .post)
    } catch {
      self.observer?.authenticationAttemptFinished(withResult: false)
    }
    
  }
  
  public func subscribeToLoginRepository(withSubscriber subscriber: LoginRepositoryObserver) {
    observer = subscriber
  }
  
  public func unsunscribeFromLoginRepository() {
    observer = nil
  }
  
}
