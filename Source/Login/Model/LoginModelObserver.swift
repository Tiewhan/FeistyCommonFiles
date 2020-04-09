//
//  LoginModelObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginModelObserver {
  
  func authenticationAttemptFinished(withResult result: Bool)
  
}
