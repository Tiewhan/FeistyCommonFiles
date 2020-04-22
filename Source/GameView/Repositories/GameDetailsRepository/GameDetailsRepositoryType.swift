//
//  GameDetailsRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/22.
//

import Foundation

public protocol GameDetailsRepositoryType: GameDetailsRepoObservable {
  
  func getGameDetails(of gameList: [Game], with serviceCaller: ServiceCaller)
  
}
