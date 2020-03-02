//
//  GameViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///The class represents the data of the ViewModel and delegates work between the View and the Model
public class GameDataViewModel {
  
  public var observerID: String = "GameDataViewModelSubscriber"
  private weak var view: GameDataLoadedType?
  private var gameManager: GameManager?
  
  public init(_ view: GameDataLoadedType) {
    self.view = view
  }
  
  /**
   Invoked by the view when the view has finished loading and can recieve data
   */
  public func viewFinishedLoading() {
    
    let gameModel = GameModel()
    
    gameManager = gameModel.getGameManager()
    gameManager?.subscribeToGameManager(subscriber: self, subscriberID: observerID)
    
  }
  
  /**
   Gets the game details that corresponds to the given index for use by the View.
   
   - Parameter index: The index of the game.
                      This index matches the index of the row position on the view on not the data source
   
   - Returns: A tuple of the necessary details for the view to display.
   */
  public func getGameDetails(at index: Int) -> (name: String, gamePrice: String) {
    
    if let game = gameManager?.gameList[index] {
      return (game.name, "R\(game.price)")
    }
    
    return ("No Name", "No price")
  }
  
  /**
   Get the ammount of data that should be displayed on the current page
   
   - Returns: The amount of items to be on the current page
   */
  public func getPageCount() -> Int {
    
    if let count = gameManager?.gameList.count {
      return count
    }
    
    return 0
    
  }
  
  /**
   Gets the game that corresponds to the given index for use by the View.
   
   - Parameter index: The index of the game.
                      This index matches the index of the row position on the view on not the data source
   
   - Returns: A game if found. Otherwise a blank game
   */
  public func getGameAt(at index: Int) -> Game {
    
    if let game = gameManager?.gameList[index] {
      return game
    }
    
    return Game(appid: "NO ID", name: "No Name")
  }
  
}

///Extends the View Model with the GameManagerObserver to react to games finished being loaded
extension GameDataViewModel: GameManagerObserver {
  
  public func gamesFinishedLoading() {
    
    if let gameList = gameManager?.gameList {
      view?.gameDataSuccessfullyLoaded(with: gameList)
    }
    
  }
  
}
