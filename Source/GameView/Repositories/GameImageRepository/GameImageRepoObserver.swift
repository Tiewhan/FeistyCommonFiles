//
//  GameImageRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public protocol GameImageRepoObserver: AnyObject {
  
  func imageFoundFor(game: Game)
  
  func failedToLoadImageFor(game: Game)
  
}
