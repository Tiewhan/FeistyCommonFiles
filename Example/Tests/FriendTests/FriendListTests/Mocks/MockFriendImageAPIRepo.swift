//
//  MockFriendImageAPIRepo.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockFriendImageAPIRepo: FriendImageRepositoryType {
  
  weak var observer: FriendImageRepoObserver?
  
  func findProfileImage(of user: User, using serviceCaller: ServiceCaller) {
    
  }
  
  func subscribeToRepository(with subscriber: FriendImageRepoObserver) {
    observer = subscriber
  }
  
  func unsubscribeFromRepository(withID observerID: String) {
    observer = nil
  }
  
}
