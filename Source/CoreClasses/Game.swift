//
//  Game.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/02/23.
//

import Foundation

///Represents a digital game.
public class Game {

  public var appID: String
  public var name: String
  public var price: Double = 0.00

  public init(gameName name: String, gamePrice price: Double) {

    self.name = name
    self.price = price
    appID = ""

  }

  public init(appid: String, name: String) {

    appID = "\(appid)"
    self.name = name

  }

  public func toString() -> String {
    return name
  }

  public func reduceMemoryLoad() {

  }

}
