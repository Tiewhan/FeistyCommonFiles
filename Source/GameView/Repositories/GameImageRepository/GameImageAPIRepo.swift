//
//  GameImageAPIRepi.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/20.
//

import Foundation

public class GameImageAPIRepo {
  
  struct DataBundleKeys {
    static let game = "game"
  }
  
  weak public var observer: GameImageRepoObserver?
  
  public init() { }
  
}

extension GameImageAPIRepo: GameImageRepositoryType {
  
  public func getHeaderImageFor(game: Game, using serviceCaller: ServiceCaller) {
    
    guard let url = URL(string: game.headerImagePath) else {
      return
    }
    
    let dataBundle = DataBundle()
    dataBundle.extraData[DataBundleKeys.game] = game
    
    serviceCaller.callFailedWithData = { error, dataBundle in
      
      let game = dataBundle.extraData[DataBundleKeys.game] as? Game ?? Game.defaultValue
      self.observer?.failedToLoadImageFor(game: game)
      
    }
    
    serviceCaller.callSucceeded = { data, dataBundle in
      
      let game = dataBundle.extraData[DataBundleKeys.game] as? Game ?? Game.defaultValue
      let image = UIImage(data: data)
      
      game.headerImage = image ?? Game.defaultHeaderImage
      
      self.observer?.imageFoundFor(game: game)
      
    }
    
    do {
      try serviceCaller.makeServiceCall(with: url, and: dataBundle)
    } catch { return }
    
  }
  
  public func subscribeToRepository(withSubscriber subscriber: GameImageRepoObserver) {
    observer = subscriber
  }
  
  public func unsubscribeFromRepository() {
    observer = nil
  }
  
}


