//
//  LoginViewModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginViewModelType {
  
  func attemptLogin(with userName: String, and password: String)
  
}
