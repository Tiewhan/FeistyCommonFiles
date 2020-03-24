//
//  File.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/18.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
  
  func assert<T, E: Error & Equatable>(
    _ expression: @autoclosure () throws -> T,
    throws error: E,
    in file: StaticString = #file,
    on line: UInt = #line) {
    
    var thrownError: Error?
    
    XCTAssertThrowsError(try expression(), file: file, line: line) {
      thrownError = $0
    }
    
    XCTAssertTrue(thrownError is E, "Unexpected Error Type: \(type(of: thrownError))", file: file, line: line)
    
    XCTAssertEqual(thrownError as? E, error, file: file, line: line)
    
  }
  
}
