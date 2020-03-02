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
  
  public func getGameManager() -> GameManager {
    return GameManager()
  }
  
}
