//
//  FriendImageRepoObservable.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public protocol FriendImageRepoObservable {
  
  var observer: FriendImageRepoObserver? { get set }
  
  func subscribeToRepository(with subscriber: FriendImageRepoObserver)
  
  func unsubscribeFromRepository(withID observerID: String)
  
}
