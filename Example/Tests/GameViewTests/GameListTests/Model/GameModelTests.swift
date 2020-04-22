//
//  GameModelTests.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CommonFiles

class GameModelTests: XCTestCase {

  var mockGameRepo: MockGameRepo!
  var mockGameViewModel: MockGameViewModel!
  var mockGameImageRepo: MockGameImageRepo!
  var systemUnderTest: GameModel!
  
    override func setUp() {
        
      mockGameRepo = MockGameRepo()
      mockGameViewModel = MockGameViewModel()
      mockGameImageRepo = MockGameImageRepo()
      
      systemUnderTest = GameModel(mockGameRepo, andImageRepo: mockGameImageRepo)
      systemUnderTest.loadData()
      
    }
  
  func testGivenModelWithRepoWhenGetPageCountIsCalledThenReturnCount() {
    
    let result = systemUnderTest.getPageCount()
    
    XCTAssert(result == 5)
    
  }
  
  func testGivenModelWithRepoWhenLoadDataIsCalledThenCheckRepoLoadsData() {
    
    systemUnderTest.loadData()
    
    XCTAssert(mockGameRepo.getGameListCalled)
    
  }
  
  func testGivenValidIndexWhenGetGameIsCalledThenGiveValidGame() {
    
    let testIndex = 2
    let validGame = Game(appid: "3", name: "Game Three")
    validGame.price = 20.00
    
    let result = systemUnderTest.getGameAt(index: testIndex)
    
    XCTAssert(result.appID == validGame.appID)
    XCTAssert(result.name == validGame.name)
    
  }
  
  func testGivenInvalidIndexWhenGetGameIsCalledThenGiveDefaultGameDetails() {
    
    let testIndex = 9
    let invalidGame = Game(appid: "N/A", name: "No Game")
    invalidGame.price = 0.00
    
    let result = systemUnderTest.getGameAt(index: testIndex)
    
    XCTAssert(result.name == invalidGame.name)
    XCTAssert(result.price == invalidGame.price)
    
  }
  
  func testGameModelGamesLoadedSubscription() {
    
    systemUnderTest.subscribeToModel(subscriber: mockGameViewModel)
    systemUnderTest.loadData()
     
    XCTAssertTrue(mockGameViewModel.gamesFinishedLoadingCalled)
    
  }
  
  func testGameModelGamesLoadedUnsubscribe() {
    
    systemUnderTest.subscribeToModel(subscriber: mockGameViewModel)
    systemUnderTest.loadData()
    
    XCTAssertTrue(mockGameViewModel.gamesFinishedLoadingCalled)
    
    systemUnderTest.unsubscribeFromModel()
    systemUnderTest.loadData()
    
    XCTAssertTrue(mockGameViewModel.gamesFinishedLoadingCalled)
    
  }

}
