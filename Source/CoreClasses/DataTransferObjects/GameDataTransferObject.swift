//
//  GameDataTransferObject.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class GameDataTransferObject: NSObject {
  
  @objc public var appID: String
  @objc public var name: String
  @objc public var price: String
  @objc public var shortDescription: String
  @objc public var developers: Array<String> = []
  @objc public var publishers: Array<String> = []
  @objc public var headerImage: UIImage?
  
  public init(appID: String,
              name: String,
              price: String,
              shortDescription: String,
              developers: Array<String>,
              publishers: Array<String>,
              headerImage: UIImage?) {
    
    self.appID = appID
    self.name = name
    self.price = price
    self.shortDescription = shortDescription
    self.developers = developers
    self.publishers = publishers
    self.headerImage = headerImage
    
  }
  
  @objc public static func mapToDTO(of game: Game) -> GameDataTransferObject {
    
    let price = game.price > 0.00 ? "R\(game.price)" : "Free"
    
    return GameDataTransferObject(appID: game.appID,
                                  name: game.name,
                                  price: price,
                                  shortDescription: game.shortDescription,
                                  developers: game.developers,
                                  publishers: game.publishers,
                                  headerImage: game.headerImage)
    
  }
  
}
