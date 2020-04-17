//
//  GameDataTransferObject.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public struct GameDataTransferObject {
  
  public var appID: String
  public var name: String
  public var price: String
  public var shortDescription: String
  public var developers:Array<String> = []
  public var publishers:Array<String> = []
  
  public static func mapToDTO(of game: Game) -> GameDataTransferObject {
    
    let price = game.price > 0.00 ? "R\(game.price)" : "Free"
    
    return GameDataTransferObject(appID: game.appID,
                                  name: game.name,
                                  price: price,
                                  shortDescription: game.shortDescription,
                                  developers: game.developers,
                                  publishers: game.publishers)
    
  }
  
}
