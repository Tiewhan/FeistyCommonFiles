//
//  FriendListModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListModelType {
  
  func getFriendList()
  
  func friendListFound(withData friends: [User])
  
  func friendListNotFound()
  
}
