//
//  ShoppingCart.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class ShoppingCart {
  
  public var shoppingList: [Game] = []
  public var total: Double {
    
    var runningTotal: Double = 0
    
    shoppingList.forEach { game in
      runningTotal += game.price
    }
    
    return runningTotal
    
  }
  
  public init() { }
  
}
