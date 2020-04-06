//
//  FriendListAPIRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

fileprivate struct jsonFriendList : Codable{
  
  let users: [jsonFriend]
  
}

fileprivate struct jsonFriend: Codable {
  
  let userID: String
  let username: String
  let status: String
  
  private enum CodingKeys: String, CodingKey {
    
    case userID = "user_id"
    case username
    case status
    
  }
  
}

class FriendListAPIRepo {
  
  private var model: FriendListModelType
  
  init(withModel model: FriendListModelType) {
    self.model = model
  }
  
}

extension FriendListAPIRepo: FriendListRepositoryType {
  
  func getFriendListData(using serviceCaller: ServiceCaller) {
    
    let friendsURL = URL(fileURLWithPath: FeistyAPIURLComponents.getFriendList)
    let dataBundle = DataBundle()
    
    serviceCaller.callSucceeded = { data, dataBundle in
      
      let friendList = self.decodeFriendList(data: data)
      
      self.model.friendListFound(withData: friendList)
      
    }
    
    serviceCaller.callFailed = { error in
      self.model.friendListNotFound()
    }
    
    do {
      try serviceCaller.makeServiceCall(with: friendsURL, and: dataBundle)
    } catch {
      
    }
    
  }
  
  private func decodeFriendList(data: Data) -> [User]{
    
    var friendList: [User] = []
    
    if let decodedFriends = try? JSONDecoder().decode(jsonFriendList.self, from: data) {
      
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
