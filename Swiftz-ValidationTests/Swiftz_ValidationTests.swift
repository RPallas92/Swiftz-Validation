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
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApplicative() {
        
        let validation3 = Validation<String, Int>.pure(3)
        let validationAdd2 = Validation<String, (Int) -> Int>.pure({$0 + 2})
        let validation5 = validation3.ap(validationAdd2)
        XCTAssert(validation5.success == 5)
    }
    
    func testAppliativeLiftA(){
        let add2 = { $0 + 2 }
        let validation3 = Validation<String, Int>.pure(3)
        let validation5 = Validation.liftA(add2) (validation3)
        XCTAssert(validation5.success == 5)
    }
    
    func testAppliativeLiftAFailure(){
        let add2 = { $0 + 2 }
        let validation3 = Validation<String, Int>.Failure("Error")
        let validation5 = Validation.liftA(add2) (validation3)
        XCTAssert(validation5.success == nil && validation5.failure == "Error")
    }
    
    func testSemigroup(){
        
        func isPasswordLongEnough(_ password:String) -> Validation<[String], String> {
            if password.characters.count < 8 {
                return Validation.Failure(["Password must have more than 6 characters."])
            } else {
                return Validation.Success(password)
            }
        }
        
        func isPasswordStrongEnough(_ password:String) -> Validation<[String], String> {
            if (password.range(of:"[\\W]", options: .regularExpression) != nil){
                return Validation.Success(password)
            } else {
                return Validation.Failure(["Password must contain a special character."])
            }
        }
        
        func isPasswordValid(password:String) -> Validation<[String], String> {
            return isPasswordLongEnough(password)
            .sconcat(isPasswordStrongEnough(password))
        }
        
        let result = isPasswordValid(password: "Richi")
        
    }
}

