//
//  GameClassTest.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import CommonFiles

class GameClassTest: XCTestCase {

  func testGivenDefaultGameWhenDefaultValueIsCalledThenGameIDIsNotApplicable() {
    
    let systemUnderTest = Game.defaultValue
    
    XCTAssert(systemUnderTest.appID == "N/A")
    
  }
  
  func testGivenDetailsWhenConstructorIsCalledWithAppIDIsCalledThenAppIDIsValid() {
    
    let testAppID = "5510256"
    let testName = "Pirates of Las Angeles"
    let systemUnderTest = Game(appid: testAppID, name: testName)
    
    XCTAssert(systemUnderTest.appID == testAppID)
    
  }
  
  func testGivenDetailsWhenConstructorIsCalledWithPriceIsCalledThenAppIDIsValid() {
    
    let testPrice = 200.00
    let testAppID = "5510256"
    let testName = "Pirates of Las Angeles"
    let systemUnderTest = Game(gameName: testName, gamePrice: testPrice)
    systemUnderTest.appID = testAppID
    
    XCTAssert(systemUnderTest.appID == testAppID)
    XCTAssertTrue(systemUnderTest.price == testPrice)
    
  }
  
}
