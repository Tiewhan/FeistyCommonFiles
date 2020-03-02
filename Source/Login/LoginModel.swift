//
//  LoginModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/27.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

public class LoginModel {
  
  /**
   Attempt a login with the given username and password. Currently does a check against hard-coded values
   
   - Parameters:
    - username: The user name of the user
    - password: The password of the user
   
   - Returns: A boolean that represents whether the authentication attempt was successful
   */
  public func attemptLogin(with username: String, and password: String) -> Bool {
    
    return username == "tiewhan" && password == "cat3"
    
  }
  
}
