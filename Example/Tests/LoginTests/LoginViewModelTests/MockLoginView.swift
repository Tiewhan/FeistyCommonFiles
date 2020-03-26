//
//  MockLoginView.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/05.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import CommonFiles

class MockLoginView: LoginType {
  
  var loginPassed: Bool
  
  init() {
    loginPassed = false
  }
  
  func authenticationSuccess() {
    loginPassed = true
  }
  
  func authenticationFailure() {
    loginPassed = false
  }
  
}
