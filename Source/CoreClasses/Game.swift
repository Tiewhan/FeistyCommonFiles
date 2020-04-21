//
//  Game.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/02/23.
//

import Foundation

///Represents a digital game.
public class Game: NSObject {

  @objc public var appID: String
  @objc public var name: String
  @objc public var price: Double = 0.00
  @objc public var shortDescription: String
  @objc public var developers: Array<String> = []
  @objc public var publishers: Array<String> = []
  @objc public var headerImagePath: String
  @objc public var headerImage: UIImage = Game.defaultHeaderImage
  
  public static var defaultValue: Game {
    
    let game = Game(appid: "N/A", name: "No Game")
    game.price = 0.00
    game.developers.append("No Developers")
    game.publishers.append("No Publishers")
    
    return game
    
  }
  
  public static var defaultHeaderImage: UIImage = #imageLiteral(resourceName: "Game Tab Bar Icon")

  @objc public init(gameName name: String,
                    gamePrice price: Double,
                    shortDescription: String = "",
                    headerImagePath: String = "") {

    self.name = name
    self.price = price
    appID = ""
    self.shortDescription = shortDescription
    self.headerImagePath = headerImagePath
    
  }

  @objc public init(appid: String,
                    name: String,
                    shortDescription: String = "",
                    headerImagePath: String = "") {

    appID = "\(appid)"
    self.name = name
    self.price = 0.00
    self.shortDescription = shortDescription
    self.headerImagePath = headerImagePath

  }

  public func toString() -> String {
    return name
  }
  
}
