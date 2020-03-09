//
//  GameModelObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameModelObservable {
  
  func subscribeToGameModelGamesLoaded(subscriber observer: GameModelObserver,
                                     subscriberID observerID: String)

  func unsubscribeFromGameModelGamesLoaded(subscriberID observerID: String)

}
