//
//  FriendListRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListRepoObserver: AnyObject {
  
  func friendsListRetrieved(withData data: [User])
  
  func failedToLoadFriends()
  
}
