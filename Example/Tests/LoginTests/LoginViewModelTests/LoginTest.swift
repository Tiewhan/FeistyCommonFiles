//
//  LoginTest.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/05.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import CommonFiles

class LoginTest: XCTestCase {

  var systemUnderTest: LoginViewModel!
  var mockLoginView: MockLoginView!
  
  override func setUp() {
    
    mockLoginView = MockLoginView()
    systemUnderTest = LoginViewModel(withView: mockLoginView)
    
  }

  func testGivenCorrectCredentialsWhenLoginIsCalledThenReturnGoodResponse() {
    
    let testUsername = "tiewhan"
    let testPassword = "cat3"
    
    systemUnderTest.attemptLogin(with: testUsername, and: testPassword)
    
    XCTAssert(mockLoginView.loginPassed)
    
  }
  
  func testGivenWrongCredentialsWhenLoginIsCalledThenReturnBadResponse() {
    
    let testUsername = "the_grey_rand"
    let testPassword = "cat3"
    
    systemUnderTest.attemptLogin(with: testUsername, and: testPassword)
    
    XCTAssertFalse(mockLoginView.loginPassed)
    
  }

}
