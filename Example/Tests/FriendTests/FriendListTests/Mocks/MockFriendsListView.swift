//
//  MockFriendsListView.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockFriendsListView: FriendListViewType {
  
  var isDataLoaded = false
  var isErrorLoadingData = false
  
  func dataLoaded() {
    isDataLoaded = true
  }
  
  func errorLoadingData() {
    isErrorLoadingData = true
  }

}
