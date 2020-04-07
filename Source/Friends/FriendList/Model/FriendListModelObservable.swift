//
//  FriendListModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListModelObservable {
  
  var observers: [String: FriendListModelObserver] { get set }
  
  func subscribeToFriendListModel(with subscriber: FriendListModelObserver, andID observerID: String)
  
  func unsubscribeFromFriendListModel(withID observerID: String)
  
}
