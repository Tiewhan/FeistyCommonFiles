//
//  SteamURLFactory.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/04.
//

import Foundation

public struct SteamURLComponents {
  
  private static let baseAPIURL: String = "https://api.steampowered.com"
  private static let baseStoreURL: String = "https://store.steampowered.com"
  
  private static let steamAppsURL: String = "/ISteamApps"
  
  public static let gameListURL = "\(baseAPIURL)\(steamAppsURL)/GetAppList/v2"
  public static let specificGameURL = "\(baseStoreURL)/api/appdetails/?appids="
  
}
