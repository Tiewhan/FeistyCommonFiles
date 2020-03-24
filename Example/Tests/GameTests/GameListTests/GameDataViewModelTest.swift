//
//  GameDataViewModelTest.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import CommonFiles

class GameDataViewModelTest: XCTestCase {

  var systemUnderTest: GameDataViewModel!
  var mockGameView: MockGameView!
  var mockGameModel: MockGameModel!
  
  override func setUp() {
    
    mockGameView = MockGameView()
    mockGameModel = MockGameModel()
    systemUnderTest = GameDataViewModel(mockGameView, with: mockGameModel)
    
  }
  
  func testGivenValidtIndexWhenGetGameIsCalledThenGiveRightGame() {
    
    let testIndex = 3
    let correctGame = Game(appid: "4", name: "Game Four")
    correctGame.price = 25.00
    
    let result = systemUnderTest.getGameAt(at: testIndex)
    
    XCTAssert(result.appID == correctGame.appID)
    XCTAssert(result.name == correctGame.name)
    XCTAssert(result.price == correctGame.price)
    
  }
  
  func testGivenInvalidIndexWhenGetGameIsCalledThenGivenDefaultGame() {
    
    let testIndex = 8
    let validGame = Game(appid: "N/A", name: "No Game")
    validGame.price = 25.00
    
    let result = systemUnderTest.getGameAt(at: testIndex)
    
    XCTAssert(result.appID == validGame.appID)
    XCTAssert(result.name == validGame.name)
    
  }
  
  func testGivenValidIndexWhenGetDetailsIsCalledThenGiveRightGameDetails() {
    
    let testIndex = 1
    let correctGame = Game(appid: "2", name: "Game Two")
    correctGame.price = 15.00
    
    let result = systemUnderTest.getGameDetails(at: testIndex)
    
    XCTAssert(result.gameName == correctGame.name)
    XCTAssert(result.gamePrice == "R\(correctGame.price)")
    
  }
  
  func testGivenInvalidIndexWhenGetDetailsIsCalledThenGiveDefaultGameDetails() {
    
  }
  
}
