//
//  File.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/06.
//

import Foundation

public protocol GameRepository: GameRepositoryObservable {
  
  func getGameList(with serviceCaller: ServiceCaller)
  
}
