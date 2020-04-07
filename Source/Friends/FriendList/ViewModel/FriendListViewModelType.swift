//
//  FriendListViewModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListViewModelType {
  
  func getFriend(at index: Int) -> UserDataTransferObject
  
  func getAmountOfFriends() -> Int
  
}
