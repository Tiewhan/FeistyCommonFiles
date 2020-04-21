//
//  FriendListModelObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListModelObserver: AnyObject {
  
  func friendListFound()
  
  func friendListNotFound()
  
  func foundProfileImage(of user: User, atIndex index: Int)
  
}
