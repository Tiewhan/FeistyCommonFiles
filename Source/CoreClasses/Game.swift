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

  @objc public init(gameName name: String, gamePrice price: Double) {

    self.name = name
    self.price = price
    appID = ""
    
    super.init()

  }

  @objc public init(appid: String, name: String) {

    appID = "\(appid)"
    self.name = name

  }

  public func toString() -> String {
    return name
  }

  public func reduceMemoryLoad() {

  }

}
