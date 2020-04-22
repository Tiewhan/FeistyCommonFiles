//
//  LoginModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginModelType: LoginModelObservable {
  
  func attemptLogin(with username: String, and password: String)
  
}
