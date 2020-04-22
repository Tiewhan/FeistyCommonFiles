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
  
  public weak var observer: GameRepositoryObserver?
  
  public init() { }
  
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
  
  private func decodeGames(data: Data) -> [Game] {
    
    var games: [Game] = []
    
    if let decodedGames = try? JSONDecoder().decode(AppList.self, from: data) {

      decodedGames.applist.apps.forEach { (jsonGame) in
        games.append(Game(appid: "\(jsonGame.appid)", name: jsonGame.name))
      }

    }
    
    return games
    
  }
  
  public func subscribeToRepository(subscriber observer: GameRepositoryObserver) {
    self.observer = observer
  }
  
  public func unsubscribeFromRepository() {
    observer = nil
  }
  
  private func notifyGameListLoaded(gameList: [Game]) {
    observer?.gameListFinishedLoading(withData: gameList)
  }
  
}
