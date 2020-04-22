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
  private let imageRepo: GameImageRepositoryType
  
  public init(_ repo: GameRepository,
              andImageRepo imageRepo: GameImageRepositoryType) {
    self.repo = repo
    self.imageRepo = imageRepo
    
    repo.subscribeToGameRepoGamesLoaded(subscriber: self, subscriberID: observerID)
    imageRepo.subscribeToRepository(withSubscriber: self)
    
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
    loadHeaderImages()
  }
  
  private func loadHeaderImages() {
    
    gameList.forEach { game in
      imageRepo.getHeaderImageFor(game: game, using: ServiceCaller())
    }
    
  }
  
}

extension GameModel: GameImageRepoObserver {
  
  public func imageFoundFor(game: Game) {
    notifyImageLoadedFor(game: game)
  }
  
  public func failedToLoadImageFor(game: Game) { }
  
  private func notifyImageLoadedFor(game: Game) {
    
    for index in 0..<gameList.count {
      
      if gameList[index].appID == game.appID {
        observers.forEach({ (observer) in
          observer.value.headerImageLoadedFor(game: game, at: index)
        })
        return
      }
      
    }
  }
  
}
