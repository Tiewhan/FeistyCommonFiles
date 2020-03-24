//
//  ServiceCallerTest.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/17.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import CommonFiles

class ServiceCallerTest: XCTestCase {

  private var systemUnderTest: ServiceCaller!
  private let testURL = URL(string: SteamURLComponents.gameListURL)!
  
    override func setUp() {
      
      systemUnderTest = ServiceCaller()
      
    }

    override func tearDown() {
      [HTTPStubs .removeAllStubs()]
    }

  func testGivenURLWhenServiceIsCalledThenGiveRightResponse() {
    
    stub(condition: isHost("api.steampowered.com")) { _ in
      
      let stubPath = OHPathForFile("gameList.json", type(of: self))
      return HTTPStubsResponse(fileAtPath: stubPath!,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
    let testExpectation = expectation(description: "FullSystemCall")
    
    systemUnderTest.callSucceeded = { data, _ in
      
      print(data)
      
      XCTAssert(true)
      testExpectation.fulfill()
    }
    
    systemUnderTest.callFailed = { _ in
      XCTAssert(false)
    }
    
    do {
    
      try systemUnderTest.makeServiceCall(with: testURL, and: DataBundle())
      
    } catch {
      
    }
    
    waitForExpectations(timeout: 10.0, handler: nil)
    
  }
  
  func testGivenServiceCallerWithNoCallSucceededCallbackWhenServiceIsCalledThenThrowError() {
    
    systemUnderTest.callFailed = { _ in
      XCTAssert(false)
    }
    
    assert(try systemUnderTest.makeServiceCall(with: testURL, and: DataBundle()),
           throws: SerivceCallerSetupError.noCallSucceededCallback)
    
  }
  
  func testGivenServiceCallerWithNoCallFailedCallbackWhenServiceIsCalledThenThrowError() {
    
    systemUnderTest.callSucceeded = { _, _ in
      XCTAssert(false)
    }
    
    assert(try systemUnderTest.makeServiceCall(with: testURL, and: DataBundle()),
           throws: SerivceCallerSetupError.noCallFailedCallback)
    
  }
  
  func testGivenFullyCreatedServiceCallerWhenResetCallerIsCalledThenCallbacksShouldBeNil() {
    
    systemUnderTest.callSucceeded = { _, _ in }
    systemUnderTest.callFailed = { _ in }
    
    systemUnderTest.resetCaller()
    
    XCTAssertNil(systemUnderTest.callSucceeded)
    XCTAssertNil(systemUnderTest.callFailed)
    
  }
  
  func testGivenWrongURLWhenServiceIsCalledThenThrowMalformedRequestError() {
    
    stub(condition: isHost("api.steampowered.com")) { _ in
      
      let stubPath = OHPathForFile("gameList.json", type(of: self))
      return HTTPStubsResponse(fileAtPath: stubPath!,
                               statusCode: 404,
                               headers: ["Content-Type": "application/json"])
      
    }
    
    let testExpectation = expectation(description: "WrongURLWhenServiceIsCalledExpectation")
    
    systemUnderTest.callSucceeded = { _, _ in
      XCTAssert(false)
    }
    
    systemUnderTest.callFailed = { error in
      
      XCTAssertEqual(error, ServiceCallError.malformedRequest)
      testExpectation.fulfill()
      
    }
    
    do {
      try systemUnderTest.makeServiceCall(with: testURL, and: DataBundle())
    } catch { }
    
    waitForExpectations(timeout: 5.0, handler: nil)
    
  }
  
}
