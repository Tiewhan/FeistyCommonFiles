//
//  ShoppingCartModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation

public protocol ShoppingCartModelObservable {
  
  var observer: ShoppingCartModelObserver? { get }
  
  func subscribeToModel(withObserver observer: ShoppingCartModelObserver)
  
  func unsubscribeFromModel()
  
}
