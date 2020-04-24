//
//  ShoppingCartModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class ShoppingCartModel {
  
  var shoppingCart: ShoppingCart
  public var coreDataRepo: ShoppingCartRepositoryType?
  public weak var observer: ShoppingCartModelObserver?
  
  public init(withShoppingCart cart: ShoppingCart?) {
    
    shoppingCart = cart ?? ShoppingCart()
    
  }
  
}

extension ShoppingCartModel: ShoppingCartModelType {
  
  public func removeItem(at index: Int) {
    shoppingCart.shoppingList.remove(at: index)
    observer?.shoppingCartGamesLoaded()
  }
  
  public func loadShoppingCart() {
    coreDataRepo?.loadShoppingCartData()
  }
  
  public func saveShoppingCart() {
    coreDataRepo?.saveData(of: shoppingCart)
    shoppingCart.shoppingList.removeAll(keepingCapacity: false)
  }
  
  public func getAmountInCart() -> Int {
    return shoppingCart.shoppingList.count
  }
  
  public func getGame(at index: Int) -> Game {
    return shoppingCart.shoppingList[index]
  }
  
  public func subscribeToModel(withObserver observer: ShoppingCartModelObserver) {
    self.observer = observer
  }
  
  public func unsubscribeFromModel() {
    observer = nil
  }
  
}

extension ShoppingCartModel: ShoppingCartRepoObserver {
  
  public func loadedData(of shoppingCart: ShoppingCart) {
    
    self.shoppingCart.shoppingList.append(contentsOf: shoppingCart.shoppingList)
    observer?.shoppingCartGamesLoaded()
    
  }
  
}
