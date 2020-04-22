//
//  GameImageRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public protocol GameImageRepoObservable {
  
  var observer: GameImageRepoObserver? { get }
  
  func subscribeToRepository(withSubscriber subscriber: GameImageRepoObserver)
  
  func unsubscribeFromRepository()
  
}
