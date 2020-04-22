//
//  FriendListAPIRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public class FriendListAPIRepo {

  struct JSONFriendList: Codable {
    let users: [JSONFriend]
  }

  struct JSONFriend: Codable {
    
    let userID: String
    let username: String
    let status: String
    
    private enum CodingKeys: String, CodingKey {
      
      case userID = "user_id"
      case username
      case status
      
    }
    
  }

  public weak var observer: FriendListRepoObserver?
  
  public init() { }
  
}

extension FriendListAPIRepo: FriendListRepositoryType {
  
  public func subscribeToRepository(with subscriber: FriendListRepoObserver) {
    observer = subscriber
  }
  
  public func unsubscribeFromRepository() {
    observer = nil
  }
  
  public func getFriendListData(using serviceCaller: ServiceCaller) {
    
    let urlString = FeistyAPIURLComponents.getFriendList
    
    guard let friendsURL = URL(string: urlString) else {
      return
    }
    
    let dataBundle = DataBundle()
    
    serviceCaller.callSucceeded = { data, dataBundle in
      
      let friendList = self.decodeFriendList(data: data)
      self.observer?.friendsListRetrieved(withData: friendList)
      
    }
    
    serviceCaller.callFailed = { error in
      self.observer?.failedToLoadFriends()
    }
    
    do {
      try serviceCaller.makeServiceCall(with: friendsURL, and: dataBundle)
    } catch { }
    
  }
  
  private func decodeFriendList(data: Data) -> [User] {
    
    var friendList: [User] = []
    
    if let decodedFriends = try? JSONDecoder().decode(JSONFriendList.self, from: data) {
      
      decodedFriends.users.forEach { friend in
        
        let userID = friend.userID
        let username = friend.username
        let status: UserStatus = UserStatus(rawValue: friend.status) ?? UserStatus.offline
        
        friendList.append(User(withUserID: userID, andUsername: username, andStatus: status))
        
      }
      
    }
    
    return friendList
    
  }
  
}
