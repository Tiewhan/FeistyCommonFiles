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
  
  var observers: [String: FriendListModelObserver] = [:]
  var friendList: [User] = []
  
  init() {
    
    friendList.append(User(withUserID: "41", andUsername: "Jackson", andStatus: .offline))
    friendList.append(User(withUserID: "51", andUsername: "Sally", andStatus: .away))
    friendList.append(User(withUserID: "61", andUsername: "Rudolph", andStatus: .online))
    friendList.append(User(withUserID: "71", andUsername: "Dasher", andStatus: .offline))
    friendList.append(User(withUserID: "81", andUsername: "Pter", andStatus: .online))
    
  }
  
  func getFriendList() {
    observers.forEach { observer in
      observer.value.friendListFound()
    }
  }
  
  func triggerListNotFound() {
    
    observers.forEach { observer in
      observer.value.friendListNotFound()
    }
    
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
  
  func subscribeToFriendListModel(with subscriber: FriendListModelObserver, andID observerID: String) {
    observers[observerID] = subscriber
  }
  
  func unsubscribeFromFriendListModel(withID observerID: String) {
    observers.removeValue(forKey: observerID)
  }
  
}
