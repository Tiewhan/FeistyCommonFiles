//
//  LoginRepositoryObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginRepositoryObserver: AnyObject {
  
  func authenticationAttemptFinished(withResult result: Bool)
  
}
