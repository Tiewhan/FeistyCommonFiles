//
//  GameModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameModelObservable {
  
  var observer: GameModelObserver? { get }
  
  func subscribeToModel(subscriber observer: GameModelObserver)

  func unsubscribeFromModel()

}
