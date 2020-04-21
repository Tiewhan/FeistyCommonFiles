//
//  FriendImageRepoObserver.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation
import UIKit

public protocol FriendImageRepoObserver: AnyObject {
  
  func foundImageOf(user: User)
  
  func errorInGettingImageOf(user: User)
  
}
