//
//  FriendListModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListModelObservable {
  
  var observer: FriendListModelObserver? { get }
  
  func subscribeToModel(with subscriber: FriendListModelObserver)
  
  func unsubscribeFromModel()
  
}
