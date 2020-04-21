//
//  FriendListRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListRepoObservable {
  
  var observer: FriendListRepoObserver? { get set }
  
  func subscribeToRepository(with subscriber: FriendListRepoObserver)
  
  func unsubscribeFromRepository()
  
}
