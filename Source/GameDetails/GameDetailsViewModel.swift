//
//  GameDetailsViewModel.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/03/02.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///A view model that represents the view and provides a way for the view to get data
public class GameDetailsViewModel {
  
  private weak var view: GameDetailsLoadedType?
  private var game: Game
  
  public init(_ view: GameDetailsLoadedType, game: Game?) {
    
    self.view = view

    if let game = game {
      self.game = game
    } else {
      self.game = Game(appid: "N/A", name: "No Title")
    }
    
  }
  
  /**
   Creates a tuple of game details and then triggers the gameDetailsFound view
   */
  public func getGameData() {
    
    let detailsTuple = (gameName: game.name, appID: game.appID)
    
    view?.gameDetailsFound(gameDetails: detailsTuple)
    
  }
  
}
