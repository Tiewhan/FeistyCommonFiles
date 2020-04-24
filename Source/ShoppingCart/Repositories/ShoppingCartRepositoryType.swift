//
//  ShoppingCartRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation

public protocol ShoppingCartRepositoryType: ShoppingCartRepoObservable {
  
  func loadShoppingCartData()
  func saveData(of shoppingCart: ShoppingCart)
  
}
