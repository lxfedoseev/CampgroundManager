//
//  CamperServiceTests.swift
//  CampgroundManagerTests
//
//  Created by Alex Fedoseev on 30.11.2018.
//  Copyright © 2018 Razeware. All rights reserved.
//

import XCTest
import CampgroundManager
import CoreData

class CamperServiceTests: XCTestCase {

  // MARK: Properties
  var camperService: CamperService!
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    
    coreDataStack = TestCoreDataStack()
    camperService = CamperService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
  }

    override func tearDown() {
      camperService = nil
      coreDataStack = nil
    }

  func testAddCamper() {
    let camper = camperService.addCamper("Bacon Lover",
                                         phoneNumber: "910-543-9000")
    XCTAssertNotNil(camper, "Camper should not be nil")
    XCTAssertTrue(camper?.fullName == "Bacon Lover")
    XCTAssertTrue(camper?.phoneNumber == "910-543-9000")
  }

  func testRootContextIsSavedAfterAddingCamper() {
    //1
    let derivedContext = coreDataStack.newDerivedContext()
    camperService = CamperService(
      managedObjectContext: derivedContext,
      coreDataStack: coreDataStack)
    //2
    expectation(
      forNotification:
      NSNotification.Name.NSManagedObjectContextDidSave.rawValue,
      object: coreDataStack.mainContext) {
        notification in
        return true
    }
    //3
    let camper = camperService.addCamper("Bacon Lover",
                                         phoneNumber: "910-543-9000")
    XCTAssertNotNil(camper)
    //4
    waitForExpectations(timeout: 2.0) { error in
      XCTAssertNil(error, "Save did not occur")
    }
  }
  
}
