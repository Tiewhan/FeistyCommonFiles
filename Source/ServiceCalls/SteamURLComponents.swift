//
//  SteamURLFactory.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/04.
//

import Foundation

struct SteamURLComponents {
  
  private static let baseAPIURL: String = "https://api.steampowered.com"
  private static let baseStoreURL: String = "https://store.steampowered.com"
  
  private static let steamAppsURL: String = "/ISteamApps"
  
  static let gameListURL = "\(baseAPIURL)\(steamAppsURL)/GetAppList/v2"
  static let specificGameURL = "\(baseStoreURL)/api/appdetails/?appids="
  
}
