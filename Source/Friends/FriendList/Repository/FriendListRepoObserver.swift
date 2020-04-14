//
//  FriendListRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListRepoObserver {
  
  var observerID: String { get }
  
  func friendsListRetrieved(withData data: [User])
  
  func failedToLoadFriends()
  
}
