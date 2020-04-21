//
//  FriendImageRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public protocol FriendImageRepositoryType: FriendImageRepoObservable {
  
  func findProfileImage(of user: User, using serviceCaller: ServiceCaller)
  
}
