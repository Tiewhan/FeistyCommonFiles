//
//  FriendListViewType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListViewType {
 
  func dataRecivedOf(friends friendList: [UserDataTransferObject])
  
}
