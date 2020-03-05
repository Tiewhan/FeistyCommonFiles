//
//  APIManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/10.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///Handles the calling of API services and also handles the decoding thereof.
public struct APIManager {

  // MARK: - Variable Declaration
  private let baseURL: String = "https://api.steampowered.com"
  private let steamAppsURL: String = "/ISteamApps"
  private let baseStoreURL: String = "https://store.steampowered.com"

  /**
              
   Queries the Steampowered API for a complete list of games offered by the Steam store
   
   - Parameter completionHandler: Escaping closure that is called when the service call returns
   
   - Returns: Nothing
   
   */
  public func getGames(completionHandler: @escaping([Game]) -> Void) {

    let specificURL = "/GetAppList/v2"
    let fullUrl: String = baseURL + steamAppsURL + specificURL + ""
    let url: URL = URL(string: fullUrl)!

    //This task will do the actual call and take the closure that is called at the end
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

      if error != nil {
        return
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return
      }

      //Unbox the data and also decode the JSON response with the AppList struct
      if
        let data = data,
        let decodedGames = try? JSONDecoder().decode(AppList.self, from: data) {

          var games: [Game] = []

          decodedGames.applist.apps.forEach { (jsonGame) in
            games.append(Game(appid: "\(jsonGame.appid)", name: jsonGame.name))
          }

          completionHandler(games)

      }
    })
    task.resume()
  }

  /**
   Retrieves the details of the given game
   
   - Parameter game: The game to find the details of
   - Parameter completionHandler: Escaping closure that is cakled when the service call returns
   */
  public func getGameDetails(of game: Game, completionHandler: @escaping ([String: Any], Game) -> Void) {

    let specificURL = "/api/appdetails/?appids=\(game.appID)"
    let url: URL = URL(string: (baseStoreURL + specificURL))!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

      if error != nil {
        return
      }

      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        return
      }

      guard let data = data else {
        return
      }

      do {

        //Wanted data is wrapped in extra keys. This unwraps its.
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let jsonWrapper = json as? [String: Any]
        let mainResponseBody = jsonWrapper?[game.appID] as? [String: Any]

        if let mainResponseBody = mainResponseBody {
          completionHandler(mainResponseBody, game)
        }

      } catch let err {
        print(err)
      }

    })

    task.resume()

  }

}
