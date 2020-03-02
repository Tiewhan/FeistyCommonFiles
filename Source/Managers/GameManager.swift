//
//  GameManager.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/06.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation

public class GameManager {

  public var gameList: [Game] = []
  private var observers: [String: GameManagerObserver] = [:]

  //TODO: Use these variables in the creation of the loader cache thingie mibob
//  var currentGameListSection: ArraySlice<Game> = ArraySlice<Game>()
//  var previousGameListSection: ArraySlice<Game> = ArraySlice<Game>()
//  var nextGameListSection: ArraySlice<Game> = ArraySlice<Game>()
  init() {

    let apiManager: APIManager = APIManager()

    loadMainList(using: apiManager)

  }

  /**
   Loads the main list by using the given API manager
   
   - Parameter apiManager: An instance of an API manager
   */
  private func loadMainList(using apiManager: APIManager) {

    apiManager.getGames { [weak self] (games) in

    var smallGameList: [Game] = []

      //This limit exists until sectioning with the table works.
      let size: Int = games.count >= 25 ? 25 : games.count

      if games.count >= 1 {

        for index in 0...(size - 1) {
          smallGameList.append(games[index])
        }

        guard let self = self else {
          return
        }

        self.gameList = smallGameList

        self.getGameDetails(of: self.gameList, using: apiManager)

      }

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
  private func getGameDetails(of games: [Game], using apiManager: APIManager) {

    let detailOperationQueue = OperationQueue()

    let detailsOperation = BlockOperation {

      let dispatchGroup = DispatchGroup()

      games.forEach { game in

        dispatchGroup.enter()
        apiManager.getGameDetails(of: game, completionHandler: self.extractGameData(detailsWrapper:game:))
        dispatchGroup.leave()

      }

      dispatchGroup.wait()

    }

    let notifyOperation = BlockOperation {

      self.notifyAllObservers()

    }

    notifyOperation.addDependency(detailsOperation)

    detailOperationQueue.addOperation(detailsOperation)
    detailOperationQueue.addOperation(notifyOperation)

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
