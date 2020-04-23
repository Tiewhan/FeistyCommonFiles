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
  private let imageRepo: GameImageRepositoryType
  private let detailsRepo: GameDetailsRepositoryType
  public var gameList: [Game] = []
  public weak var observer: GameModelObserver?
  
  public init(_ repo: GameRepository,
              andImageRepo imageRepo: GameImageRepositoryType,
              andDetailsRepo detailsRepo: GameDetailsRepositoryType) {
    self.repo = repo
    self.imageRepo = imageRepo
    self.detailsRepo = detailsRepo
    
    repo.subscribeToRepository(subscriber: self)
    imageRepo.subscribeToRepository(withSubscriber: self)
    detailsRepo.subscribeToRepository(subscriber: self)
    
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
      return Game.defaultValue
    }
    
    return gameList[index]
    
  }
  
  public func subscribeToModel(subscriber observer: GameModelObserver) {
    self.observer = observer
  }

  public func unsubscribeFromModel() {
    observer = nil
  }

}

extension GameModel: GameRepositoryObserver {
  
  public func gameListFinishedLoading(withData gameList: [Game]) {
    self.gameList = gameList
    detailsRepo.getGameDetails(of: gameList, with: ServiceCaller())
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
        observer?.headerImageLoadedFor(game: game, at: index)
        return
      }
      
    }
  }
  
}

extension GameModel: GameDetailsRepoObserver {
  
  public func gameDetailsFinishedLoading(withData gameList: [Game]) {
    self.gameList = gameList
    observer?.gamesFinishedLoading()
    loadHeaderImages()
  }
  
  private func loadHeaderImages() {
    
    gameList.forEach { game in
      imageRepo.getHeaderImageFor(game: game, using: ServiceCaller())
    }
    
  }
  
}
