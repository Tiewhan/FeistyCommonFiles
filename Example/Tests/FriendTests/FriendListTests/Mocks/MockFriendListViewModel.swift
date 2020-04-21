//
//  MockFriendListViewModel.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockFriendListViewModel: FriendListViewModelType {
  
  var isFriendListFound: Bool
  var isFriendListNotFound: Bool
  var isProfileImageFound: Bool
  
  init() {
    
    isFriendListFound = false
    isFriendListNotFound = false
    isProfileImageFound = false
    
  }
  
  func getFriend(at index: Int) -> UserDataTransferObject {
    return UserDataTransferObject.mapToDTO(of: User.defaultValue)
  }
  
  func getAmountOfFriends() -> Int {
    return 0
  }
  
}

extension MockFriendListViewModel: FriendListModelObserver {
  
  func foundProfileImage(of user: User, atIndex index: Int) {
    isProfileImageFound = true
  }
  
  func friendListFound() {
    isFriendListFound = true
  }
  
  func friendListNotFound() {
    isFriendListNotFound = true
  }
  
}
