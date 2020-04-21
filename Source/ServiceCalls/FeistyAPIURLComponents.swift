//
//  FeistyAPIURLComponents.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/06.
//

import Foundation

struct FeistyAPIURLComponents {
  
  //private static let httpProtocol = "https://"
  //private static let domainName = "feisty-server.herokuapp.com"
  private static let httpProtocol = "http://"
  private static let domainName = "localhost:8080"
  
  private static let friendsPath = "friends"
  private static let loginPath = "login"
  
  private static let protocolAndHostName = httpProtocol + domainName
  
  static let getFriendList = "\(protocolAndHostName)/\(friendsPath)"
  static let loginURL = "\(protocolAndHostName)/\(loginPath)"
  public static let imageURL = "\(protocolAndHostName)/friendImage"
  
}
