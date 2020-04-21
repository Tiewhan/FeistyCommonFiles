//
//  FriendListViewType.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public protocol FriendListViewType: AnyObject {
 
  func dataLoaded()
  
  func errorLoadingData()
  
  func foundImageOfCell(at index: Int, image: UIImage?)
  
}
