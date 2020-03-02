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
  private var corePrice: Double?
  
  // MARK: All properties (Except appID and name) need to be set to null by the reduce memory load
  // MARK: method
  var price: Double {
  
    get {
  
      if let corePrice = corePrice {
        return corePrice
      }
  
        return 0.0
    }
  
    set {
       corePrice = newValue
     }
  
  }

  public init(gameName name: String, gamePrice price: Double) {

    self.name = name
    corePrice = price
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
    corePrice = nil
  }

}
