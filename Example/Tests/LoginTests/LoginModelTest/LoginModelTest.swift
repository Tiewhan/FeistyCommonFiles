//
//  LoginModelTest.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import Feisty
@testable import CommonFiles

class LoginModelTest: XCTestCase {

  var systemUnderReview: LoginModel!
  
  override func setUp() {
    systemUnderReview = LoginModel()
  }

  func testGivenCorrectCredentialsWhenLogginIsCalledThenGivePositiveResponse() {
    
    let testUsername: String = "tiewhan"
    let testPassword: String = "cat3"
    
    let result = systemUnderReview.attemptLogin(with: testUsername, and: testPassword)
    
    XCTAssert(result)
    
  }
  
  func testGivenIncorrectCredentialsWhenLogginIsCalledThenGiveNegativeResponse() {
    
    let testUsername: String = "tiewhan"
    let testPassword: String = "t3"
    
    let result = systemUnderReview.attemptLogin(with: testUsername, and: testPassword)
    
    XCTAssertFalse(result)
    
  }
  
}
