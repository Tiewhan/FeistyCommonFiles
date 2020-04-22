//
//  MockGameRepo.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockGameRepo {
  
  var observer: GameRepositoryObserver?
  var gameList: [Game] = []
  var getGameListCalled = false
  var getGameDetailsCalled = false
  var subscriberAdded = false
  
  init() {
    
    gameList.append(Game(appid: "1", name: "Game One"))
    gameList[0].price = 10.00
    gameList.append(Game(appid: "2", name: "Game Two"))
    gameList[1].price = 15.00
    gameList.append(Game(appid: "3", name: "Game Three"))
    gameList[2].price = 20.00
    gameList.append(Game(appid: "4", name: "Game Four"))
    gameList[3].price = 25.00
    gameList.append(Game(appid: "5", name: "Game Five"))
    gameList[4].price = 30.00
    
  }
  
}

extension MockGameRepo: GameRepository {
  
  func getGameList(with serviceCaller: ServiceCaller) {
    
    getGameListCalled = true
    observer?.gameListFinishedLoading(withData: gameList)
    
  }
  
  func getGameDetails(of gameList: [Game], with serviceCaller: ServiceCaller) {
    
    getGameDetailsCalled = true
    observer?.gameDetailsFinishedLoading(withData: self.gameList)
    
  }
  
  func subscribeToRepository(subscriber observer: GameRepositoryObserver) {
    self.observer = observer
    subscriberAdded = true
  }
  
  func unsubscribeFromRepository() {
    observer = nil
    subscriberAdded = false
  }
  
}
