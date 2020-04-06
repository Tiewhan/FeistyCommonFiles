//
//  FriendListViewModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public class FriendListViewModel {
  
  private var view: FriendListViewType
  
  init(withView view: FriendListViewType) {
    self.view = view
  }
  
  private func friendDataRecieved() {
    
    let friendsList: [UserDataTransferObject] = []
    
    view.dataRecivedOf(friends: friendsList)
    
  }
  
}

extension FriendListViewModel: FriendListViewModelType {
  
  public func getFriendList() {
    
  }
  
}
