//
//  ShoppingCartViewModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public class ShoppingCartViewModel {
  
  public var model: ShoppingCartModelType?
  
  public init() { }
  
}

extension ShoppingCartViewModel: ShoppingCartViewModelType {
  
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
