//
//  LoginModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

public class LoginModel {
  
  public weak var observer: LoginModelObserver?
  private var repo: LoginRepositoryType
  
  public init(withRepo repo: LoginRepositoryType = LoginAPIRepo()) {
    self.repo = repo
    repo.subscribeToLoginRepository(withSubscriber: self)
  }
  
}

extension LoginModel: LoginModelType {
  
  public func attemptLogin(with username: String, and password: String) {
    repo.attemptLogin(withUsername: username,
                      andPassword: password,
                      using: ServiceCaller())
  }
  
  public func subscribeToLoginModel(withSubscriber suscriber: LoginModelObserver) {
    observer = suscriber
  }
  
  public func unsubscribeFromLoginModel() {
    observer = nil
  }
  
}

extension LoginModel: LoginRepositoryObserver {
  
  public func authenticationAttemptFinished(withResult result: Bool) {
    observer?.authenticationAttemptFinished(withResult: result)
  }
  
}
