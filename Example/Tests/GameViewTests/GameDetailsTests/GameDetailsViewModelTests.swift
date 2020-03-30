//
//  GameDetailsViewModel.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CommonFiles

class GameDetailsViewModelTests: XCTestCase {

  var mockGameDetailsLoadedType: MockGameDetailsLoadedType!
  var systemUnderTest: GameDetailsViewModel!
  var mockSelectedGame: Game!
  
    override func setUp() {
        
      mockSelectedGame = Game(appid: "556312", name: "Los Angeles Pirates")
      mockSelectedGame.price = 25.00
      mockSelectedGame.developers = ["id Software"]
      mockSelectedGame.publishers = ["Bethesda"]
      
      mockGameDetailsLoadedType = MockGameDetailsLoadedType()
      systemUnderTest = GameDetailsViewModel(mockGameDetailsLoadedType, mockSelectedGame)
      
    }

    func testGivenASelectedGameWhenGetGameDataIsCalledThenCallLoadedTypeMethodAndProperDataPassed() {
      
      systemUnderTest.getGameData()
      
      XCTAssert(mockGameDetailsLoadedType.gameDetailsFoundCalled)
      XCTAssertFalse(mockGameDetailsLoadedType.gameDetailsIsDefault)
      
    }
  
  func testGivenDefaultGameWhenGetGameDataIsCalledThenCallLoadedTypeMethodAndDefaultDataPassed() {
    
    systemUnderTest.selectedGame = Game.defaultValue
    systemUnderTest.getGameData()
    
    XCTAssert(mockGameDetailsLoadedType.gameDetailsFoundCalled)
    XCTAssert(mockGameDetailsLoadedType.gameDetailsIsDefault)
    
  }

}
