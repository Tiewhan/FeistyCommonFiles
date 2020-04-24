//
//  ShoppingCartViewModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class ShoppingCartViewModel {
  
  public var model: ShoppingCartModelType?
  public weak var view: ShoppingCartViewType?
  
  public init() { }
  
}

extension ShoppingCartViewModel: ShoppingCartViewModelType {
  
  public func removeItem(at index: Int) {
    model?.removeItem(at: index)
  }
  
  public func loadShoppingCart() {
    model?.loadShoppingCart()
  }
  
  public func saveShoppingCart() {
    model?.saveShoppingCart()
  }
  
  public func getAmountInCart() -> Int {
    return model?.getAmountInCart() ?? 0
  }
  
  public func getGame(at index: Int) -> GameDataTransferObject {
    
    guard let model = model else {
      return GameDataTransferObject.mapToDTO(of: Game.defaultValue)
    }
    
    return GameDataTransferObject.mapToDTO(of: model.getGame(at: index))
    
  }
  
}

extension ShoppingCartViewModel: ShoppingCartModelObserver {
  
  public func shoppingCartGamesLoaded() {
    view?.gamesInCartLoaded()
  }
  
}
