//
//  GameManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

///Structure is only used to model JSON respones. Contains the a structure of Apps
struct AppList: Codable {
  let applist: Apps
}

///Structure is used to model JSON respones. Contains the list of games
struct Apps: Codable {
  let apps: [JsonGame]
}

///Structure is used to model JSON respones. This is the actual game
struct JsonGame: Codable {
  let appid: Int
  let name: String
}

public class GameManager {

  public var gameList: [Game] = []
  private var observers: [String: GameManagerObserver] = [:]

  init() {

    loadMainList()

  }

  /**
   Loads the main list by using the given API manager
   
   - Parameter apiManager: An instance of an API manager
   */
  private func loadMainList() {

    let serviceCaller = ServiceCaller()
    
    let url: URL = URL(string: SteamURLComponents.gameListURL)!
    
    // MARK: - Call Failed Closure
    serviceCaller.callFailed = { error in
      
    }
    
    // MARK: - ---------------------------

    // MARK: - Call Succeeded Closure
    serviceCaller.callSucceeded = { [weak self] data, _ in

      guard let self = self else {
        return
      }

      let games = self.decodeGames(data: data)

      var smallGameList: [Game] = []

      //This limit exists until sectioning with the table works.
      let size: Int = games.count >= 25 ? 25 : games.count

      if games.count >= 1 {

        for index in 0...(size - 1) {
          smallGameList.append(games[index])
        }

        self.gameList = smallGameList

        self.getGameDetails(of: self.gameList)

      }

    }
    
    // MARK: - ---------------------------
    
    serviceCaller.makeServiceCall(with: url, and: DataBundle())
    
  }
  
  private func decodeGames(data: Data) -> [Game] {
    
    var games: [Game] = []
    
    if let decodedGames = try? JSONDecoder().decode(AppList.self, from: data) {

      decodedGames.applist.apps.forEach { (jsonGame) in
        games.append(Game(appid: "\(jsonGame.appid)", name: jsonGame.name))
      }

    }
    
    return games
    
  }
  
  private func decodeGameDetails(using data: Data, basedOn game: Game) {
    
    do {

      //Wanted data is wrapped in extra keys. This unwraps its.
      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      let jsonWrapper = json as? [String: Any]
      let mainResponseBody = jsonWrapper?[game.appID] as? [String: Any]

      if let mainResponseBody = mainResponseBody {
        self.extractGameData(detailsWrapper: mainResponseBody, game: game)
      }

    } catch let err {
      print(err)
    }
    
  }
  
  /**
   Uses an operation queue and dispatch group to retrieve the game details of all the elements in the given array
   
   The proccess is as follows:
      Create an Operation Queue
      The first operation block creates a DispatchGroup and gets the details for each game in the list
      The second operation block triggers the event that notifies all Manager Listeners of games finished loading
   
   - Parameter games: The list of games that the details need to be found
   - Parameter apiManager: The manager to use for the calls
   */
  private func getGameDetails(of games: [Game]) {

      let dispatchGroup = DispatchGroup()

      games.forEach { game in

        dispatchGroup.enter()
        
        let serviceCaller = ServiceCaller()
        
        let dataBundle = DataBundle()
        dataBundle.extraData["game"] = game
        
        // MARK: - Call Succeeded Closure
        serviceCaller.callSucceeded = { [weak self] data, dataBundle in
          
          guard let game = dataBundle.extraData["game"] as? Game else {
            return
          }
          
          guard let self = self else {
            return
          }
          
          self.decodeGameDetails(using: data, basedOn: game)
          
        }
        
        // MARK: - ---------------------------

        // MARK: - Call Failed Closure
        serviceCaller.callFailed = { error in
          
        }
        
        // MARK: - ---------------------------

        dispatchGroup.leave()

      }

      dispatchGroup.wait()

      notifyAllObservers()

  }

  /**
   Extract the needed data to set the remaining properties of the given game from the given dictionary
   
   - Parameter detailsWrapper: The dictionary that contains the data
   - Parameter game: A reference to the game that the data is for
   */
  private func extractGameData(detailsWrapper: [String: Any], game: Game) {

    guard let gameDetailsData = detailsWrapper["data"] as? [String: Any] else {
      return
    }

    guard let priceOverview = gameDetailsData["price_overview"] as? [String: Any] else {
      return
    }

    game.price = Double((priceOverview["final"] as? Int ?? 0)/100)

  }

  /**
   Allows class and structs that confrom to the GameManagerObserver protocol to react to
   certain events triggered by the manager
   
   - Parameter observer: The class/struct that conforms to the GameManagerObserver protocol
   - Parameter observerID: The unique ID that is needed to identify the observer
   */
  public func subscribeToGameManager(subscriber observer: GameManagerObserver,
                                     subscriberID observerID: String) {
    observers[observerID] = observer
  }

  /**
   Removes a class/struct from the list of subsrcibers that get notified about GameManager events
   
   - Parameter observerID: The ID of the observer to remove from the list
   */
  public func unsubscribeFromGameManager(subscriberID observerID: String) {
    observers.removeValue(forKey: observerID)
  }

  /**
   Iterates through of the GameManagerOservers and notifies all of them about an event.
   */
  private func notifyAllObservers() {
    observers.forEach({ (observer) in
      observer.value.gamesFinishedLoading()
    })
  }

}
