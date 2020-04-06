//
//  FriendListModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation


public class FriendListModel {
  
  private let viewModel: FriendListViewModelType
  
  init(withViewModel viewModel: FriendListViewModelType) {
    self.viewModel = viewModel
  }
  
}

extension FriendListModel: FriendListModelType {
  
  public func getFriendList() {
    
  }
  
}
