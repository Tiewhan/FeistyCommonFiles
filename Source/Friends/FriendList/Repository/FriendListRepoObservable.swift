//
//  FriendListRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListRepoObservable {
  
  var observers: [String: FriendListRepoObserver] { get set }
  
  func subscribeToFriendListModel(with subscriber: FriendListRepoObserver, andID observerID: String)
  
  func unsubscribeFromFriendListModel(withID observerID: String)
  
}
