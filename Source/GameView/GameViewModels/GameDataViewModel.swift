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
  private var model: GameModelProtocol
  
  public init(_ view: GameDataLoadedType, with model: GameModelProtocol) {
    self.view = view
    self.model = model
    
    model.subscribeToGameModelGamesLoaded(subscriber: self, subscriberID: observerID)
    model.loadData()
    
  }
  
  /**
   Gets the game details that corresponds to the given index for use by the View.
   
   - Parameter index: The index of the game.
                      This index matches the index of the row position on the view on not the data source
   
   - Returns: A tuple of the necessary details for the view to display.
   */
  public func getGameDetails(at index: Int) -> (gameName: String, gamePrice: String) {
    
    let game = model.getGameAt(index: index)
    
    let gameDetails = (gameName: game.name, gamePrice: "R\(game.price)")
    
    return gameDetails
    
  }
  
  public func getGameAt(at index: Int) -> Game {
    return model.getGameAt(index: index)
  }
  
  /**
   Get the ammount of data that should be displayed on the current page
   
   - Returns: The amount of items to be on the current page
   */
  public func getPageCount() -> Int {
    
    return model.getPageCount()
    
  }
  
}

///Extends the View Model with the GameManagerObserver to react to games finished being loaded
extension GameDataViewModel: GameModelObserver {
  
  public func gamesFinishedLoading() {
    
    view?.gameDataSuccessfullyLoaded(with: model.gameList)
    
  }
  
}
