//
//  GameManagerObserver.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

public protocol GameModelObserver {
  
  var observerID: String { get set }
  func gamesFinishedLoading()
  func headerImageLoadedFor(game: Game, at index: Int)
  
}
