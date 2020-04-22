//
//  GameImageRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public protocol GameImageRepositoryType: GameImageRepoObservable {
  
  func getHeaderImageFor(game: Game, using serviceCaller: ServiceCaller)
  
}
