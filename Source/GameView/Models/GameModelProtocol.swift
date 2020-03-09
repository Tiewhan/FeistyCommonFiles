//
//  GameModelProtocol.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameModelProtocol : GameModelObservable {
  
  var gameList: [Game] { get set }
  
  func loadData()
  
  func getGameAt(index: Int) -> Game
  
  func getPageCount() -> Int
  
}


