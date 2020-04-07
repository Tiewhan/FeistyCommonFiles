//
//  FriendListRepositoryType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListRepositoryType: FriendListRepoObservable {
  
  func getFriendListData(using serviceCaller: ServiceCaller)
  
}
