//
//  GameModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/03/02.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///The GameModel class retrieves data when asked by the View Model
public class GameModel {
  
  private let repo: GameRepository
  public var observerID: String = "GameModelObserver"
  
  public init(_ repo: GameRepository) {
    self.repo = repo
    
    repo.subscribeToGameRepoGamesLoaded(subscriber: self, subscriberID: observerID)
    
  }
  
  public var gameList: [Game] = []
  
  private var observers: [String: GameModelObserver] = [:]
  
  private func notifyAllObservers() {
    observers.forEach({ (observer) in
      observer.value.gamesFinishedLoading()
    })
  }
  
  private func loadGameDetails(of gameList: [Game]) {
    repo.getGameDetails(of: gameList, with: ServiceCaller())
  }
  
}

extension GameModel: GameModelProtocol {
  
  public func getPageCount() -> Int {
    return gameList.count
  }
  
  public func loadData() {
   repo.getGameList(with: ServiceCaller())
  }
  
  public func getGameAt(index: Int) -> Game {
    
    if (index >= gameList.count) || (index <= -1) {
      return Game(gameName: "No Game", gamePrice: 0.00)
    }
    
    return gameList[index]
    
  }
  
  public func subscribeToGameModelGamesLoaded(subscriber observer: GameModelObserver,
                                              subscriberID observerID: String) {
    observers[observerID] = observer
  }

  public func unsubscribeFromGameModelGamesLoaded(subscriberID observerID: String) {
    observers.removeValue(forKey: observerID)
  }

}

extension GameModel: GameRepositoryObserver {
  
  public func gameListFinishedLoading(withData gameList: [Game]) {
    self.gameList = gameList
    loadGameDetails(of: gameList)
  }
  
  public func gameDetailsFinishedLoading(withData gameList: [Game]) {
    self.gameList = gameList
    notifyAllObservers()
  }
  
}
