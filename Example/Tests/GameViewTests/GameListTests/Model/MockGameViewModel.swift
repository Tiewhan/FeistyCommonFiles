//
//  MockGameViewModel.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockGameViewModel {
  var observerID: String = ""
  var gamesFinishedLoadingCalled = false
}

extension MockGameViewModel: GameModelObserver {
  
  func gamesFinishedLoading() {
    gamesFinishedLoadingCalled = gamesFinishedLoadingCalled ? false : true
  }
  }
