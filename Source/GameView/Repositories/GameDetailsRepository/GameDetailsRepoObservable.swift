//
//  GameDetailsRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/22.
//

import Foundation

public protocol GameDetailsRepoObservable {
  
  var observer: GameDetailsRepoObserver? { get }
  
  func subscribeToRepository(subscriber observer: GameDetailsRepoObserver)

  func unsubscribeFromRepository()
  
}
