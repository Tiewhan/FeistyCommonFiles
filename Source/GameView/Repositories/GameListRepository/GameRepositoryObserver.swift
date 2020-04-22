//
//  GameRepositoryObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameRepositoryObserver: AnyObject {
  
  func gameListFinishedLoading(withData gameList: [Game])
  
  func gameDetailsFinishedLoading(withData gameList: [Game])
  
}
