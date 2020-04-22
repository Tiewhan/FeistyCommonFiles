//
//  GameDetailsRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/22.
//

import Foundation

public protocol GameDetailsRepoObserver: AnyObject {
  
  func gameDetailsFinishedLoading(withData gameList: [Game])
  
}
