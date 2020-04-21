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
  
  weak var observer: FriendListRepoObserver?
  
  func getFriendListData(using serviceCaller: ServiceCaller) {
    
    var friendList: [User] = []
    
    friendList.append(User(withUserID: "41", andUsername: "Jackson", andStatus: .offline))
    friendList.append(User(withUserID: "51", andUsername: "Sally", andStatus: .away))
    friendList.append(User(withUserID: "61", andUsername: "Rudolph", andStatus: .online))
    friendList.append(User(withUserID: "71", andUsername: "Dasher", andStatus: .offline))
    friendList.append(User(withUserID: "81", andUsername: "Pter", andStatus: .online))
    
    observer?.friendsListRetrieved(withData: friendList)
    
  }
  
  func triggerDataFailedToLoad() {
      observer?.failedToLoadFriends()
  }
  
  func subscribeToRepository(with subscriber: FriendListRepoObserver) {
    observer = subscriber
  }
  
  func unsubscribeFromRepository() {
    observer = nil
  }
  
}
