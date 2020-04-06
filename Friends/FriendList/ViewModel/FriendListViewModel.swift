//
//  FriendListViewModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public class FriendListViewModel {
  
  private var view: FriendListViewType
  private var model: FriendListModelType
  
  init(withView view: FriendListViewType, andModel model: FriendListModelType) {
    self.view = view
    self.model = model
  }
  
  private func friendDataRecieved(withData friends: [User]) {
    view.dataRecivedOf(friends: mapDataToDTO(from: friends))
  }
  
  private func mapDataToDTO(from data: [User]) -> [UserDataTransferObject] {
    
    var dataTransferObjectList: [UserDataTransferObject] = []
    
    data.forEach { element in
      
      let userID: String = element.userID
      let username: String = element.username
      let status: String = element.status.rawValue
      
      dataTransferObjectList.append(UserDataTransferObject(userID: userID, username: username, status: status))
      
    }
    
    return dataTransferObjectList
    
  }
  
}

extension FriendListViewModel: FriendListViewModelType {
  
  public func getFriendList() {
    model.getFriendList()
  }
  
  public func friendListFound(withData friends: [User]) {
    friendDataRecieved(withData: friends)
  }
  
}
