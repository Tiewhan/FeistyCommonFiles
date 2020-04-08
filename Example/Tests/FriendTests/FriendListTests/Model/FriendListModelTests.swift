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
  
  override func setUp() {
    
    mockViewModel = MockFriendListViewModel()
    mockAPIRepo = MockFriendListAPIRepo()
    systemUnderTest = FriendListModel(withRepo: mockAPIRepo)
    
  }
  
//  func getFriendList()
//
//  func getAmountOfFriends() -> Int
//
//  func getFriend(at index: Int) -> User
  
  func testGivenSuccessfulFriendListCallWhenGetFriendListIsCalledThenLoadDataAndTriggerEventToViewModel() {
    
    systemUnderTest.subscribeToFriendListModel(with: mockViewModel, andID: mockViewModel.observerID)
    
    let expectedListSize = 5
    systemUnderTest.getFriendList()
    
    XCTAssertTrue(systemUnderTest.getAmountOfFriends() == expectedListSize)
    XCTAssertTrue(mockViewModel.isFriendListFound == true)
    
  }
  
  func testGivenNegativeFriendListCallWhenGetFriendListIsCalledThenLoadDataAndTriggerEventToViewModel() {
    
    systemUnderTest.subscribeToFriendListModel(with: mockViewModel, andID: mockViewModel.observerID)
    
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
    
    let expectedResult = 1
    
    systemUnderTest.subscribeToFriendListModel(with: mockViewModel, andID: mockViewModel.observerID)
    
    let result = systemUnderTest.observers.count
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
  func testUnsubscribeFromFriendListModel() {
    
    var expectedResult = 1
    
    systemUnderTest.subscribeToFriendListModel(with: mockViewModel, andID: mockViewModel.observerID)
    
    var result = systemUnderTest.observers.count
    
    XCTAssertTrue(result == 1)
    
    systemUnderTest.unsubscribeFromFriendListModel(withID: mockViewModel.observerID)
    
    expectedResult = 0
    result = systemUnderTest.observers.count
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
}
