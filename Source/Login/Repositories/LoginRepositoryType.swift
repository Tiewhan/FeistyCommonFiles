//
//  LoginRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginRepositoryType: LoginRepositoryObservable {
  
  func attemptLogin(withUsername username: String,
                    andPassword password: String,
                    using serviceCaller: ServiceCaller)
  
}
