//
//  MockGameDetailsLoadedType.swift
//  CommonFiles_Tests
//
//  Created by Tiewhan Smith on 2020/03/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonFiles

class MockGameDetailsLoadedType: NSObject, GameDetailsLoadedType {
  
  var gameDetailsFoundCalled: Bool = false
  var gameDetailsIsDefault: Bool = true
  
  func gameDetailsFound(_ withGameName: String, _ andAppID: String, _ price: String, _ shortDescription: String, _ developers: String, _ publishers: String) {
    
    gameDetailsFoundCalled = true
    
    validateData(usingID: andAppID)
    
  }
  
  func validateData(usingID appID: String) {
    
    let defaultGame = Game.defaultValue
    
    if appID != defaultGame.appID {
      gameDetailsIsDefault = false
    }
    
  }
  
}
