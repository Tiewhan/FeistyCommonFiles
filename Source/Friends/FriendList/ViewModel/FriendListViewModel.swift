//
//  FriendListViewModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public class FriendListViewModel {
  
  private weak var view: FriendListViewType?
  private var model: FriendListModelType
  
  public init(withView view: FriendListViewType, andModel model: FriendListModelType) {
    self.view = view
    self.model = model
    
    self.model.subscribeToFriendListModel(with: self, andID: observerID)
    self.model.getFriendList()
    
  }
  
  private func friendDataRecieved() {
    view?.dataLoaded()
  }
  
}

extension FriendListViewModel: FriendListViewModelType {
  
  public func getFriend(at index: Int) -> UserDataTransferObject {
    return UserDataTransferObject.mapToDTO(of: model.getFriend(at: index))
  }
  
  public func getAmountOfFriends() -> Int {
    return model.getAmountOfFriends()
  }
  
}

extension FriendListViewModel: FriendListModelObserver {
  
  public var observerID: String {
    return "FriendListViewModelObserver"
  }
  
  public func friendListNotFound() {
    view?.errorLoadingData()
  }
  
  public func friendListFound() {
    friendDataRecieved()
  }
  
}
