//
//  Swiftz_ValidationTests.swift
//  Swiftz-ValidationTests
//
//  Created by Ricardo Pallás on 09/09/2017.
//  Copyright © 2017 Ricardo Pallas. All rights reserved.
//

import XCTest
@testable import SwiftzValidation

class Swiftz_ValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let validation = Validation()
        let result = validation.validate(value: "hack")
        XCTAssert(result)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
