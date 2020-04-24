//
//  CoreGameData+CoreDataClass.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation
import CoreData

@objc(CoreDataGame)
public class CoreDataGame: NSManagedObject {
  
  @NSManaged public var appID: String
  @NSManaged public var name: String
  @NSManaged public var price: Double
  @NSManaged public var gameDescription: String
  @NSManaged public var developer: String
  @NSManaged public var publisher: String
  @NSManaged public var headerImagePath: String
  @NSManaged public var headerImage: NSData?
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataGame> {
    return NSFetchRequest<CoreDataGame>(entityName: CoreDataGame.className)
  }
  
  public func mapToGame() -> Game {
    
    let game = Game(appid: appID,
                    name: name,
                    shortDescription: gameDescription,
                    headerImagePath: headerImagePath)
    
    var developer = [String]()
    var publisher = [String]()
    
    developer.append(self.developer)
    publisher.append(self.publisher)
    
    game.price = price
    game.developers = developer
    game.publishers = publisher
    
    if let data = headerImage as Data? {
      game.headerImage = UIImage(data: data)
    }
    
    return game
    
  }
  
}
