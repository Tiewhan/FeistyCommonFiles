//
//  GameRepositoryObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/09.
//

import Foundation

public protocol GameRepositoryObserver {
  var observerID: String { get set }
  
  func gameListFinishedLoading(withData gameList: [Game])
  
  func gameDetailsFinishedLoading(withData gameList: [Game])
  
}
