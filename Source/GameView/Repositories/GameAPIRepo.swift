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
  
  //TODO: Replace gameList with individual game and make the model call the function many times.
  public func getGameDetails(of gameList: [Game], with serviceCaller: ServiceCaller) {
    
    let dispatchGroup = DispatchGroup()
    
    gameList.forEach({ (game) in
      
      dispatchGroup.enter()
      
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
      
      let urlString = "\(SteamURLComponents.specificGameURL)\(game.appID)"
      let url: URL = URL(string: urlString)!
      
      do {
        try serviceCaller.makeServiceCall(with: url, and: dataBundle)
      } catch {
        fatalError("Service call not set up properly")
      }
      
      dispatchGroup.leave()
      
    })
    
    dispatchGroup.wait()
    
    self.notifyGameDetailsLoaded(withData: gameList)
    
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

    guard let gameDetailsData = detailsWrapper["data"] as? [String: Any] else {
      return
    }

    if let priceOverview = gameDetailsData["price_overview"] as? [String: Any] {
      game.price = Double((priceOverview["final"] as? Int ?? 0)/100)
    }
    
    if let shortDescription = gameDetailsData["short_description"] as? String {
      game.shortDescription = shortDescription
    }
    
    if let developers = gameDetailsData["developers"] as? Array<String> {
      game.developers = developers
    }
    
    if let publishers = gameDetailsData["publishers"] as? Array<String> {
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
