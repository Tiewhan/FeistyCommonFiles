//
//  FriendListModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation


public class FriendListModel {
  
  public var observers: [String : FriendListModelObserver] = [:]
  
  private let repo: FriendListRepositoryType
  private var friendList: [User] = []
  
  public init(withRepo repo: FriendListRepositoryType) {
    self.repo = repo
    
    self.repo.subscribeToFriendListModel(with: self, andID: observerID)
    
  }
  
}

extension FriendListModel: FriendListModelType {
  
  public func getFriend(at index: Int) -> User {
    return friendList[index]
  }
    public func subscribeToFriendListModel(with subscriber: FriendListModelObserver, andID observerID: String) {
    observers[observerID] = subscriber
  }
  
  public func unsubscribeFromFriendListModel(withID observerID: String) {
    observers.removeValue(forKey: observerID)
  }
  
  public func getFriendList() {
    repo.getFriendListData(using: ServiceCaller())
  }
  
  public func getAmountOfFriends() -> Int {
    return friendList.count
  }
  
}

extension FriendListModel: FriendListRepoObserver {
  
  public var observerID: String {
    return "FriendListModelObserver"
  }
  
  public func friendsListRetrieved(withData data: [User]) {
    
    friendList = data
    
    observers.forEach { observer in
      observer.value.friendListFound()
    }
    
  }
  
  public func failedToLoadFriends() {
    
    observers.forEach { observer in
      observer.value.friendListNotFound()
    }
    
  }
  
}
