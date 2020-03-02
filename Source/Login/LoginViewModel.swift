//
//  LoginViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

public class LoginViewModel {
  
  private weak var view: LoginType?
  
  public init(withView view: LoginType) {
    self.view = view
  }
  
  /**
   Call on the LoginModel to attempt a login with the given details.
   Calls authenticationSuccess() on the ViewModel view if successful
   Calls authenticationFailure() on the ViewModel view if failed
   
   - Parameters:
    - userName: The username of the user
    - password: The password of the user
   */
  public func attemptLogin(with userName: String, and password: String) {
    
    let model = LoginModel()
    
    let loggedIn = model.attemptLogin(with: userName, and: password)
    
    if loggedIn {
      view?.authenticationSuccess()
    } else {
      view?.authenticationFailure()
    }
    
  }
  
}
