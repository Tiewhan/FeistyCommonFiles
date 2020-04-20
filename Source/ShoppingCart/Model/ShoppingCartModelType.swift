//
//  ShoppingCartModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public protocol ShoppingCartModelType {
  
  func getAmountInCart() -> Int
  func getGame(at index: Int) -> Game
  
}
