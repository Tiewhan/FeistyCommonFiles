//
//  MockFriendListAPIRepo.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockFriendListAPIRepo: FriendListRepositoryType {
  
  var observers: [String : FriendListRepoObserver] = [:]
  
  func getFriendListData(using serviceCaller: ServiceCaller) {
    
    var friendList: [User] = []
    
    friendList.append(User(withUserID: "41", andUsername: "Jackson", andStatus: .offline))
    friendList.append(User(withUserID: "51", andUsername: "Sally", andStatus: .away))
    friendList.append(User(withUserID: "61", andUsername: "Rudolph", andStatus: .online))
    friendList.append(User(withUserID: "71", andUsername: "Dasher", andStatus: .offline))
    friendList.append(User(withUserID: "81", andUsername: "Pter", andStatus: .online))
    
    observers.forEach { observer in
      observer.value.friendsListRetrieved(withData: friendList)
    }
    
  }
  
  func triggerDataFailedToLoad() {
    observers.forEach { observer in
      observer.value.failedToLoadFriends()
    }
  }
  
  func subscribeToFriendListModel(with subscriber: FriendListRepoObserver, andID observerID: String) {
    observers[observerID] = subscriber
  }
  
  func unsubscribeFromFriendListModel(withID observerID: String) {
    observers.removeValue(forKey: observerID)
  }
  
}
