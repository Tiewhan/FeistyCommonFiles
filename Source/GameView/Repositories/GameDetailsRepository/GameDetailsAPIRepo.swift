//
//  GameDetailsAPIRepository.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/22.
//

import Foundation

public class GameDetailsAPIRepo {
  
  struct gameDataBundleKeys {
    static let game: String = "game"
  }

  struct gameDetailsJSONResponseKeys {
    
    static let data: String = "data"
    static let priceOverview: String = "price_overview"
    static let finalPriceOverview: String = "final"
    static let shortDescription: String = "short_description"
    static let developers: String = "developers"
    static let publishers: String = "publishers"
    static let headerImage: String = "header_image"
    
  }

  public weak var observer: GameDetailsRepoObserver?
  
  public init() { }
  
}

extension GameDetailsAPIRepo: GameDetailsRepositoryType {
  
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
  
  public func subscribeToRepository(subscriber observer: GameDetailsRepoObserver) {
    self.observer = observer
  }
  
  public func unsubscribeFromRepository() {
    observer = nil
  }
  
  private func createServiceCallBlockOperation(using serviceCaller: ServiceCaller,
                                               forGamesList gameList: [Game]) -> BlockOperation {
    
    let serviceCallOperation = BlockOperation {
      
      let dispatchGroup = DispatchGroup()
      
      gameList.forEach({ (game) in
        
        let urlString = "\(SteamURLComponents.specificGameURL)\(game.appID)"
        guard let url = URL(string: urlString) else {
          return
        }
        
        dispatchGroup.enter()
        
        let dataBundle = DataBundle()
        dataBundle.extraData[gameDataBundleKeys.game] = game
        
        // MARK: - Call Succeeded Closure
        serviceCaller.callSucceeded = { [weak self] data, dataBundle in
          
          guard let self = self else {
            dispatchGroup.leave()
            return
          }
          
          guard let game = dataBundle.extraData[gameDataBundleKeys.game] as? Game else {
            dispatchGroup.leave()
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
  
  private func notifyGameDetailsLoaded(withData gameList: [Game]) {
    observer?.gameDetailsFinishedLoading(withData: gameList)
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
    
    if let headerImagePath = gameDetailsData[gameDetailsJSONResponseKeys.headerImage] as? String {
      game.headerImagePath = headerImagePath
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

    } catch { }
    
  }
  
}
