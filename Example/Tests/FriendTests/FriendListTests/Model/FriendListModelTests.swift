//
//  FriendListModelTests.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CommonFiles

class FriendListModelTests: XCTestCase {

  var systemUnderTest: FriendListModel!
  var mockViewModel: MockFriendListViewModel!
  var mockAPIRepo: MockFriendListAPIRepo!
  var mockImageAPIRepo: MockFriendImageAPIRepo!
  
  override func setUp() {
    
    mockViewModel = MockFriendListViewModel()
    mockAPIRepo = MockFriendListAPIRepo()
    mockImageAPIRepo = MockFriendImageAPIRepo()
    systemUnderTest = FriendListModel(withRepo: mockAPIRepo,
                                      andImageRepo: mockImageAPIRepo)
    
  }
  
  func testGivenSuccessfulFriendListCallWhenGetFriendListIsCalledThenLoadDataAndTriggerEventToViewModel() {
    
    systemUnderTest.subscribeToModel(with: mockViewModel)
    
    let expectedListSize = 5
    systemUnderTest.getFriendList()
    
    XCTAssertTrue(systemUnderTest.getAmountOfFriends() == expectedListSize)
    XCTAssertTrue(mockViewModel.isFriendListFound == true)
    
  }
  
  func testGivenNegativeFriendListCallWhenGetFriendListIsCalledThenLoadDataAndTriggerEventToViewModel() {
    
    systemUnderTest.subscribeToModel(with: mockViewModel)
    
    mockAPIRepo.triggerDataFailedToLoad()
    
    XCTAssertTrue(mockViewModel.isFriendListNotFound == true)
    
  }
  
  func testGivenRepoWhenGetAmountOfFriendsCalledThenReturnRightNumberOfFriends() {
    
    systemUnderTest.getFriendList()
    
    let expectedResult = 5
    let result = systemUnderTest.getAmountOfFriends()
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
  func testGivenRightIndexWhenGetFriendAtIsCalledThenReturnCorrectFriend() {
    
    systemUnderTest.getFriendList()
    
    let expectedResult = User(withUserID: "71", andUsername: "Dasher", andStatus: .offline)
    let result = systemUnderTest.getFriend(at: 3)
    
    XCTAssertTrue(result.userID == expectedResult.userID)
    XCTAssertTrue(result.username == expectedResult.username)
    XCTAssertTrue(result.status == expectedResult.status)
    
  }
  
  func testGivenInvalidIndexWhenGetFriendAtIsCalledThenReturnDefaultFriend() {
    
    systemUnderTest.getFriendList()
    
    let expectedResult = User.defaultValue
    let result = systemUnderTest.getFriend(at: -1)
    
    XCTAssertTrue(result.userID == expectedResult.userID)
    XCTAssertTrue(result.username == expectedResult.username)
    XCTAssertTrue(result.status == expectedResult.status)
    
  }
  
  func testSubscribeToFriendListModel() {
    
    let expectedResult = true
    
    systemUnderTest.subscribeToModel(with: mockViewModel)
    
    let result = systemUnderTest.observer != nil
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
  func testUnsubscribeFromFriendListModel() {
    
    let expectedResult = true
    
    systemUnderTest.subscribeToModel(with: mockViewModel)
    
    var result = systemUnderTest.observer != nil
    
    XCTAssertTrue(result == expectedResult)
    
    systemUnderTest.unsubscribeFromModel()
    
    result = systemUnderTest.observer == nil
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
}
