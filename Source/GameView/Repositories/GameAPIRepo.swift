//
//  GameAPIRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/06.
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

fileprivate struct gameDataBundleKeys {
  static let game: String = "game"
}

fileprivate struct gameDetailsJSONResponseKeys {
  
  static let data: String = "data"
  static let priceOverview: String = "price_overview"
  static let finalPriceOverview: String = "final"
  static let shortDescription: String = "short_description"
  static let developers: String = "developers"
  static let publishers: String = "publishers"
  
}

public class GameAPIRepo: GameRepository {
  
  private var observers: [String: GameRepositoryObserver] = [:]
  
  public init() {
    
  }
  
  public func getGameList(with serviceCaller: ServiceCaller) {

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

        self.notifyGameListLoaded(gameList: smallGameList)

      }

    }
    
    // MARK: - ---------------------------
    
    do {
      try serviceCaller.makeServiceCall(with: url, and: DataBundle())
    } catch {
      fatalError("Service call not set up properly")
    }
    
  }
  
  public func getGameDetails(of gameList: [Game], with serviceCaller: ServiceCaller) {
    
    let operationQueue = OperationQueue()
    
    let serviceCallOperation = createServiceCallBlockOperation(using: serviceCaller,
                                                               forGamesList: gameList)
    
    let notifyOperation = BlockOperation {
      self.notifyGameDetailsLoaded(withData: gameList)
    }
    
    notifyOperation.addDependency(serviceCallOperation)
    
    operationQueue.addOperation(serviceCallOperation)
    operationQueue.addOperation(notifyOperation)
    
  }
  
  private func createServiceCallBlockOperation(using serviceCaller: ServiceCaller,
                                               forGamesList gameList: [Game]) -> BlockOperation {
    
    let serviceCallOperation = BlockOperation {
      
      let dispatchGroup = DispatchGroup()
      
      gameList.forEach({ (game) in
        
        dispatchGroup.enter()
        
        let dataBundle = DataBundle()
        dataBundle.extraData[gameDataBundleKeys.game] = game
        
        // MARK: - Call Succeeded Closure
        serviceCaller.callSucceeded = { [weak self] data, dataBundle in
          
          guard let game = dataBundle.extraData[gameDataBundleKeys.game] as? Game else {
            return
          }
          
          guard let self = self else {
            return
          }
          
          self.decodeGameDetails(using: data, basedOn: game)
          
          dispatchGroup.leave()
          
        }
        
        // MARK: - ---------------------------

        // MARK: - Call Failed Closure
        serviceCaller.callFailed = { error in
          dispatchGroup.leave()
        }
        
        // MARK: - ---------------------------
        
        let urlString = "\(SteamURLComponents.specificGameURL)\(game.appID)"
        let url: URL = URL(string: urlString)!
        
        do {
          try serviceCaller.makeServiceCall(with: url, and: dataBundle)
        } catch {
          dispatchGroup.leave()
          fatalError("Service call not set up properly")
        }
        
      })
      
      dispatchGroup.wait()
      
    }
    
    return serviceCallOperation
    
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
  
  private func extractGameData(detailsWrapper: [String: Any], game: Game) {

    guard let gameDetailsData = detailsWrapper[gameDetailsJSONResponseKeys.data] as? [String: Any] else {
      return
    }

    if let priceOverview = gameDetailsData[gameDetailsJSONResponseKeys.priceOverview] as? [String: Any] {
      game.price = Double((priceOverview[gameDetailsJSONResponseKeys.finalPriceOverview] as? Int ?? 0)/100)
    }
    
    if let shortDescription = gameDetailsData[gameDetailsJSONResponseKeys.shortDescription] as? String {
      game.shortDescription = shortDescription
    }
    
    if let developers = gameDetailsData[gameDetailsJSONResponseKeys.developers] as? Array<String> {
      game.developers = developers
    }
    
    if let publishers = gameDetailsData[gameDetailsJSONResponseKeys.publishers] as? Array<String> {
      game.publishers = publishers
    }
    
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
  
  public func subscribeToGameRepoGamesLoaded(subscriber observer: GameRepositoryObserver,
                                             subscriberID observerID: String) {
    observers[observerID] = observer
  }
  
  public func unsubscribeFromGameRepoGamesLoaded(subscriberID observerID: String) {
    observers.removeValue(forKey: observerID)
  }
  
  private func notifyGameListLoaded(gameList: [Game]) {
    observers.forEach({ (observer) in
      observer.value.gameListFinishedLoading(withData: gameList)
    })
  }
  
  private func notifyGameDetailsLoaded(withData gameList: [Game]) {
    observers.forEach({ (observer) in
      observer.value.gameDetailsFinishedLoading(withData: gameList)
    })
  }
  
}
