//
//  ShoppingCartRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation

public protocol ShoppingCartRepoObserver: AnyObject {
  
  func loadedData(of shoppingCart: ShoppingCart)
  
}
