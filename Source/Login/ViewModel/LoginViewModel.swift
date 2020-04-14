//
//  LoginViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import FirebaseAnalytics

public class LoginViewModel {
  
  private weak var view: LoginType?
  private var model: LoginModelType
  
  public init(withView view: LoginType, andWithModel model: LoginModelType = LoginModel()) {
    self.view = view
    self.model = model
    
    model.subscribeToLoginModel(withSubscriber: self)
  }
  
}

extension LoginViewModel: LoginViewModelType {
  
  public func attemptLogin(with userName: String, and password: String) {
    model.attemptLogin(with: userName, and: password)
  }
  
}

extension LoginViewModel: LoginModelObserver {
  
  public func authenticationAttemptFinished(withResult result: Bool) {
    
    if result == true {
      view?.authenticationSuccess()
      Analytics.logEvent(AnalyticsEventLogin, parameters: [:])
    } else {
      view?.authenticationFailure()
    }
    
  }
  
}
