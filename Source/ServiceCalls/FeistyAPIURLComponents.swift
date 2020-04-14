//
//  FeistyAPIURLComponents.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

struct FeistyAPIURLComponents {
  
  static let httpProtocol = "http://"
  static let domainName = "localhost"
  static let portNumber = ":8080"
  
  static let friendsPath = "friends"
  
  static let protocolAndHostName = httpProtocol + domainName + portNumber
  
  static let getFriendList = "\(protocolAndHostName)/\(friendsPath)"
  
}
