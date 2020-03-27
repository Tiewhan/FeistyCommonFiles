//
//  MockGameModel.swift
//  FeistyTests
//
//  Created by Tiewhan Smith on 2020/03/09.
//  Copyright © 2020 DVT. All rights reserved.
//

import XCTest
@testable import CommonFiles

class MockGameModel: GameModelProtocol {
  var gameList: [Game] = []
  var gameLoadedObservers: [String:GameModelObserver] = [:]
  
  func loadData() {
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
  
  func notifyGameLoadedObservers() {
    gameLoadedObservers.forEach { _,observer in
      observer.gamesFinishedLoading()
    }
  }
  
  func getGameAt(index: Int) -> Game {
    
    if index >= gameList.count {
      return Game.defaultValue
    }
    
    if index <= -1 {
      return Game.defaultValue
    }
    
    return gameList[index]
  }
  
  func getPageCount() -> Int {
    return gameList.count
  }
  
  func subscribeToGameModelGamesLoaded(subscriber observer: GameModelObserver, subscriberID observerID: String) {
    gameLoadedObservers[observerID] = observer
  }
  
  func unsubscribeFromGameModelGamesLoaded(subscriberID observerID: String) {
    gameLoadedObservers.removeValue(forKey: observerID)
  }
  
}
