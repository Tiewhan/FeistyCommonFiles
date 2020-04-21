//
//  FriendListModel.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public class FriendListModel {
  
  public weak var observer: FriendListModelObserver?
  
  private let repo: FriendListRepositoryType
  private let imageRepo: FriendImageRepositoryType
  private var friendList: [User] = []
  
  public init(withRepo repo: FriendListRepositoryType,
              andImageRepo imageRepo: FriendImageRepositoryType) {
    self.repo = repo
    self.imageRepo = imageRepo
    
    self.repo.subscribeToRepository(with: self)
    self.imageRepo.subscribeToRepository(with: self)
    
  }
  
}

extension FriendListModel: FriendListModelType {
  
  public func getFriend(at index: Int) -> User {
    
    if index < 0 || index >= friendList.count {
      return User.defaultValue
    }
    return friendList[index]
    
  }
  
  public func subscribeToModel(with subscriber: FriendListModelObserver) {
    observer = subscriber
  }
  
  public func unsubscribeFromModel() {
    observer = nil
  }
  
  public func getFriendList() {
    repo.getFriendListData(using: ServiceCaller())
  }
  
  public func getAmountOfFriends() -> Int {
    return friendList.count
  }
  
}

extension FriendListModel: FriendListRepoObserver {
  
  public func friendsListRetrieved(withData data: [User]) {
    friendList = data
    observer?.friendListFound()
    
    friendList.forEach { friend in
      imageRepo.findProfileImage(of: friend, using: ServiceCaller())
    }
    
  }
  
  public func failedToLoadFriends() {
    observer?.friendListNotFound()
  }
  
}

extension FriendListModel: FriendImageRepoObserver {
  
  public func foundImageOf(user: User) {
    
    for index in 0..<friendList.count {
      
      if friendList[index].userID == user.userID {
        observer?.foundProfileImage(of: user, atIndex: index)
      }
      
    }
    
  }
  
  public func errorInGettingImageOf(user: User) {
    foundImageOf(user: user)
  }
  
}
