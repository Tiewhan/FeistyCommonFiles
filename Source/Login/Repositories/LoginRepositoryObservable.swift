//
//  LoginRepositoryObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/08.
//

import Foundation

public protocol LoginRepositoryObservable {
  
  var observer: LoginRepositoryObserver? { get set }
  
  func subscribeToLoginRepository(withSubscriber subscriber: LoginRepositoryObserver)
  
  func unsunscribeFromLoginRepositoruy()
  
}
