//
//  MockGameImageRepo.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockGameImageRepo: GameImageRepositoryType {
  
  weak var observer: GameImageRepoObserver?
  
  func getHeaderImageFor(game: Game, using serviceCaller: ServiceCaller) {
    observer?.imageFoundFor(game: game)
  }
  
  func subscribeToRepository(withSubscriber subscriber: GameImageRepoObserver) {
    observer = subscriber
  }
  
  func unsubscribeFromRepository() {
    observer = nil
  }
  
  
}
