//
//  GameRepositoryObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameRepositoryObservable {
  
  var observer: GameRepositoryObserver? { get }
  
  func subscribeToRepository(subscriber observer: GameRepositoryObserver)

  func unsubscribeFromRepository()
  
}
