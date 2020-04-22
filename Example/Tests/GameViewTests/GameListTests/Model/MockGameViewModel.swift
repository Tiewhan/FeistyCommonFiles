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
  var isHeaderImageLoaded = false
}

extension MockGameViewModel: GameModelObserver {
  
  func headerImageLoadedFor(game: Game, at index: Int) {
    isHeaderImageLoaded = true
  }
  
  func gamesFinishedLoading() {
    gamesFinishedLoadingCalled = gamesFinishedLoadingCalled ? false : true
  }
  }
