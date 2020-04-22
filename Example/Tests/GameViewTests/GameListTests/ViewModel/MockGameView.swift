//
//  MockGameView.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
@testable import CommonFiles

class MockGameView: GameDataLoadedType {
  
  var gameDataLoaded: Bool = false
  var isHeaderImageLoaded: Bool = false
  
  func gameDataSuccessfullyLoaded(with data: [Game]) {
    gameDataLoaded = true
  }
  
  func headerImageLoadedForGame(at index: Int, withImage image: UIImage?) {
    isHeaderImageLoaded = true
  }
  
}
