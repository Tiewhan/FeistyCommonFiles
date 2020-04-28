//
//  ShoppingCartCoreDataRepo.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation
import CoreData

public class ShoppingCartCoreDataRepo {
  
  public weak var observer: ShoppingCartRepoObserver?
  public var appDelegate: CoreDataAppDelegate
  private let context: NSManagedObjectContext
  
  public init(withAppDelegate appDelegate: CoreDataAppDelegate) {
    self.appDelegate = appDelegate
    
    context = appDelegate.persistentContainer.viewContext
    
  }
  
}

extension ShoppingCartCoreDataRepo: ShoppingCartRepositoryType {
  
  public func saveData(of shoppingCart: ShoppingCart) {
    
    clearAllData()
    
    guard let entity = NSEntityDescription.entity(forEntityName: CoreDataGame.className, in: context) else {
      return
    }
    
    shoppingCart.shoppingList.forEach { game in
      
      let coreDataGame = NSManagedObject(entity: entity, insertInto: context) as? CoreDataGame
      coreDataGame?.appID = game.appID
      coreDataGame?.name = game.name
      coreDataGame?.price = game.price
      coreDataGame?.gameDescription = game.shortDescription
      coreDataGame?.developer = game.developers[0]
      coreDataGame?.publisher = game.publishers[0]
      coreDataGame?.headerImagePath = game.headerImagePath
      
      if let data = game.headerImage?.pngData() {
        coreDataGame?.headerImage = NSData(data: data)
      }
      
      appDelegate.saveContext()
      
    }
    
  }
  
  public func loadShoppingCartData() {
    
    let request = CoreDataGame.fetchRequest() as NSFetchRequest<CoreDataGame>
  
    guard let list = try? context.fetch(request) else {
      return
    }
    
    let shoppingCart = ShoppingCart()
    shoppingCart.shoppingList = list.map { $0.mapToGame() }
    
    observer?.loadedData(of: shoppingCart)
    
  }
  
  public func subscribeToRepository(withObserver observer: ShoppingCartRepoObserver) {
    self.observer = observer
  }
  
  public func unsubscribeFromRepository() {
    observer = nil
  }
  
  private func clearAllData() {
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataGame.className)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try context.execute(deleteRequest)
    } catch { }
    
  }
  
}
