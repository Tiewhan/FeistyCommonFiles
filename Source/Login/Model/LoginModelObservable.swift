//
//  LoginModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginModelObservable {
  
  var observer: LoginModelObserver? { get set }
  
  func subscribeToLoginModel(withSubscriber suscriber: LoginModelObserver)
  
  func unsubscribeFromLoginModel()
  
}
