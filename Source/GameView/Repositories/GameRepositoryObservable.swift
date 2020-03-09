//
//  GameRepositoryObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameRepositoryObservable {
  
  func subscribeToGameRepoGamesLoaded(subscriber observer: GameRepositoryObserver,
                                     subscriberID observerID: String)

  func unsubscribeFromGameRepoGamesLoaded(subscriberID observerID: String)
  
}
