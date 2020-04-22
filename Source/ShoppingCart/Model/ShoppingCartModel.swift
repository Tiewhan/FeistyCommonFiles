//
//  ShoppingCartModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class ShoppingCartModel {
  
  let shoppingCart: ShoppingCart
  
  public init(shoppingCart: ShoppingCart) {
    self.shoppingCart = shoppingCart
  }
  
}

extension ShoppingCartModel: ShoppingCartModelType {
  
  public func getAmountInCart() -> Int {
    return shoppingCart.shoppingList.count
  }
  
  public func getGame(at index: Int) -> Game {
    return shoppingCart.shoppingList[index]
  }
  
}
