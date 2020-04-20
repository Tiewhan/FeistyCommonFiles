//
//  MockFiendsListModel.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockFriendsListModel: FriendListModelType {
  
  weak var observer: FriendListModelObserver?
  
  var friendList: [User] = []
  
  init() {
    
    friendList.append(User(withUserID: "41", andUsername: "Jackson", andStatus: .offline))
    friendList.append(User(withUserID: "51", andUsername: "Sally", andStatus: .away))
    friendList.append(User(withUserID: "61", andUsername: "Rudolph", andStatus: .online))
    friendList.append(User(withUserID: "71", andUsername: "Dasher", andStatus: .offline))
    friendList.append(User(withUserID: "81", andUsername: "Pter", andStatus: .online))
    
  }
  
  func getFriendList() {
    observer?.friendListFound()
  }
  
  func triggerListNotFound() {
    observer?.friendListNotFound()
  }
  
  func getAmountOfFriends() -> Int {
    return friendList.count
  }
  
  func getFriend(at index: Int) -> User {
    
    if index < 0 || index >= friendList.count {
      return User.defaultValue
    }
    return friendList[index]
    
  }
  
  func subscribeToModel(with subscriber: FriendListModelObserver) {
    observer = subscriber
  }
  
  func unsubscribeFromModel() {
    observer = nil
  }
  
}
