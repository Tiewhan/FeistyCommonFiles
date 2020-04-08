//
//  User.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public enum UserStatus: String{
  
  case online = "Online"
  case offline = "Offline"
  case away = "Away"
  
}

public class User {
  
  let userID: String
  var username: String
  var status: UserStatus
  
  public static var defaultValue: User {
    return User(withUserID: "N/A", andUsername: "No Username", andStatus: .offline)
  }
  
  public init(withUserID userID: String, andUsername username: String, andStatus status: UserStatus) {
    
    self.userID = userID
    self.username = username
    self.status = status
    
  }
  
}
