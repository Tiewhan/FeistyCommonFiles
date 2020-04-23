//
//  MockGameDetailRepo.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/04/22.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockGameDetailRepo {
  
  public weak var observer: GameDetailsRepoObserver?
  var isGameDetailsCalled = false
  
}

extension MockGameDetailRepo: GameDetailsRepositoryType {
  
  func getGameDetails(of gameList: [Game], with serviceCaller: ServiceCaller) {
    
    isGameDetailsCalled = true
    observer?.gameDetailsFinishedLoading(withData: gameList)
    
  }
  
  func subscribeToRepository(subscriber observer: GameDetailsRepoObserver) {
    self.observer = observer
  }
  
  func unsubscribeFromRepository() {
    observer =  nil
  }
  
}
