//
//  PersistenceManager.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 08/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
  
  private init() {}
  static let shared = PersistenceManager()
  
  // MARK: - Core Data stack
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Tricog_Wikipedia_Example")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  lazy var context = persistentContainer.viewContext
  
  // MARK: - Core Data Saving support
  
  func save() {
    if context.hasChanges {
      do {
        try context.save()
        print("saved successfully")
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
    
    let entityName = String(describing: objectType)
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects ?? [T]()
      
    } catch {
      print(error)
      return [T]()
    }
    
  }
  
  
  
}
