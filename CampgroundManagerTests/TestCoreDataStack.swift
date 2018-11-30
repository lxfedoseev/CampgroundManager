//
//  TestCoreDataStack.swift
//  CampgroundManagerTests
//
//  Created by Alex Fedoseev on 30.11.2018.
//  Copyright © 2018 Razeware. All rights reserved.
//

@testable import CampgroundManager
import Foundation
import CoreData

class TestCoreDataStack: CoreDataStack {
  
  convenience init() {
    self.init(modelName: "CampgroundManager")
}
  
  override init(modelName: String) {
    
    super.init(modelName: modelName)
    
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(name: modelName)
    container.persistentStoreDescriptions =
      [persistentStoreDescription]
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as? NSError {
        fatalError(
          "Unresolved error \(error), \(error.userInfo)")
      }
      
    }
    self.storeContainer = container
  }
  
}
