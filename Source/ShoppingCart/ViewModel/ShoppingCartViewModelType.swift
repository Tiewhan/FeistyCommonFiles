//
//  ShoppingCartViewModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public protocol ShoppingCartViewModelType {

  var model: ShoppingCartModelType? { get set }
  var view: ShoppingCartViewType? { get set }
  
  func getAmountInCart() -> Int
  func getGame(at index: Int) -> GameDataTransferObject
  func saveShoppingCart()
  func loadShoppingCart()
  func removeItem(at index: Int)
  
}
