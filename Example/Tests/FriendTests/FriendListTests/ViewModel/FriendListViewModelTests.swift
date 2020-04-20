//
//  FriendListViewModelTests.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/07.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CommonFiles

class FriendListViewModelTests: XCTestCase {

  var systemUnderTest: FriendListViewModel!
  var mockView: MockFriendsListView!
  var mockModel: MockFriendsListModel!
  
  override func setUp() {
      
    mockView = MockFriendsListView()
    mockModel = MockFriendsListModel()
    systemUnderTest = FriendListViewModel(withView: mockView, andModel: mockModel)
    
  }

  func testGivenValidIndexWhenGetGameIsCalledThenGiveProperGameDetails() {
    
    let expectedResult = UserDataTransferObject(userID: "71", username: "Dasher", status: "Offline")
    let result = systemUnderTest.getFriend(at: 3)
    
    XCTAssertTrue(result.userID == expectedResult.userID)
    XCTAssertTrue(result.username == expectedResult.username)
    XCTAssertTrue(result.status == expectedResult.status)
    
  }
  
  func testGivenInvalidIndexWhenGetGameIsCalledThenGiveDefaultGameDetails() {
    
    let expectedResult = UserDataTransferObject.mapToDTO(of: User.defaultValue)
    let result = systemUnderTest.getFriend(at: -1)
    
    XCTAssertTrue(result.userID == expectedResult.userID)
    XCTAssertTrue(result.username == expectedResult.username)
    XCTAssertTrue(result.status == expectedResult.status)
    
  }
  
  func testGivenDataIsLoadedWhenGetAmountOfFriendsIsCalledThenGiveTheCurrentAmountOfFriends() {
    
    let expectedResult = 5
    let result = systemUnderTest.getAmountOfFriends()
    
    XCTAssertTrue(result == expectedResult)
    
  }
  
  func testGivenInstructionToStartLoadWhenViewModelConstructorIsCalledAndPassedThenCallbackForDataLoadedCalled() {
    
    mockModel.subscribeToModel(with: systemUnderTest)
    mockModel.getFriendList()
    
    let result = mockView.isDataLoaded
    
    XCTAssertTrue(result == true)
    
  }
  
  func testGivenInstructionToStartLoadWhenViewModelConstructorIsCalledAndFailedThenCallbackForDataNotLoadedCalled() {
    
    mockModel.subscribeToModel(with: systemUnderTest)
    mockModel.triggerListNotFound()
    
    let result = mockView.isDataLoaded
    
    XCTAssertTrue(result == true)
    
  }
  
}
