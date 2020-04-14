//
//  UserDataTransferObject.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

public struct UserDataTransferObject {
  
  public let userID: String
  public let username: String
  public let status: String
  
  public static func mapToDTO(of user: User) -> UserDataTransferObject {
    
    return UserDataTransferObject(userID: user.userID, username: user.username, status: user.status.rawValue)
    
  }
  
}
