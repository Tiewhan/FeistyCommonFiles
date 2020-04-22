//
//  ShoppingCartModelType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/17.
//

import Foundation

public protocol ShoppingCartModelType: AnyObject {
  
  func getAmountInCart() -> Int
  func getGame(at index: Int) -> Game
  
}
