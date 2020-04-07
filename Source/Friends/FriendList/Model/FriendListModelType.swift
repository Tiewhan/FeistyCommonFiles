//
//  FriendListModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListModelType: FriendListModelObservable {
  
  func getFriendList()
  
  func getAmountOfFriends() -> Int
  
  func getFriend(at index: Int) -> User
  
}
