//
//  CoreDataWrapper.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation
import CoreData

public protocol CoreDataAppDelegate {
  
  var persistentContainer: NSPersistentContainer { get set }
  
  func saveContext()
  
}
