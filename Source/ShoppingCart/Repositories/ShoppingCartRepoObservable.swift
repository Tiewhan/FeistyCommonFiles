//
//  ShoppingCartRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation

public protocol ShoppingCartRepoObservable {
  
  var observer: ShoppingCartRepoObserver? { get }
  
  func subscribeToRepository(withObserver observer: ShoppingCartRepoObserver)
  
  func unsubscribeFromRepository()
  
}
