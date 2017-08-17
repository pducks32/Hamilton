//
//  Angles.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Hamilton

@available(iOS 10.0, *)
class Angles: XCTestCase {
    
    override func setUp() {
        super.setUp()
        FixUnitAngleConversion()
    }
    
    
    func testFirstQuadrantDegreeLiteralConversion() {
        let actualZero = 0.degrees.converted(to: .radians).value
        XCTAssertEqual(actualZero, 0)
        
        let actualThirty = 30.degrees.converted(to: .radians).value
        XCTAssertEqual(actualThirty, Double.pi / 6)
        
        let actualFourtyFive = 45.degrees.converted(to: .radians).value
        XCTAssertEqual(actualFourtyFive, Double.pi / 4)
        
        let actualNinety = 90.degrees.converted(to: .radians).value
        XCTAssertEqual(actualNinety, Double.pi / 2)
    }
    
    func testNegativeFirstQuadrantDegreeLiteralConversion() {
        let actualZero = 0.degrees.converted(to: .radians).value
        XCTAssertEqual(actualZero, 0)
        
        let actualThirty = -30.degrees.converted(to: .radians).value
        XCTAssertEqual(actualThirty, -Double.pi / 6)
        
        let actualFourtyFive = -45.degrees.converted(to: .radians).value
        XCTAssertEqual(actualFourtyFive, -Double.pi / 4)
        
        let actualNinety = -90.degrees.converted(to: .radians).value
        XCTAssertEqual(actualNinety, -Double.pi / 2)
    }
    
    func testSecondFirstQuadrantDegreeLiteralConversion() {
        let twoPi = 2 * Double.pi
        let actualZero = 360.degrees.converted(to: .radians).value
        XCTAssertEqual(actualZero, twoPi)
        
        let actualThirty = 390.degrees.converted(to: .radians).value
        XCTAssertEqual(actualThirty, twoPi + Double.pi / 6)
        
        let actualFourtyFive = 405.degrees.converted(to: .radians).value
        XCTAssertEqual(actualFourtyFive, twoPi + Double.pi / 4)
        
        let actualNinety = 450.degrees.converted(to: .radians).value
        XCTAssertEqual(actualNinety, twoPi + Double.pi / 2)
    }
    
    func testMeasurementCosine() {
        let angle = 30.degrees
        let actual = cos(angle)
        XCTAssertEqual(actual, cos(Double.pi / 6))
        XCTAssertEqual(actual, 3.0.squareRoot() / 2, accuracy: Double.ulpOfOne)
    }
    
    func testMeasurementSine() {
        let angle = 120.degrees
        let actual = sin(angle)
        XCTAssertEqual(actual, sin(2 * Double.pi / 3))
        XCTAssertEqual(actual, 3.0.squareRoot() / 2, accuracy: Double.ulpOfOne)
    }
    
    func testPatriansLiteral() {
        let patrianValue = 2.patrians
        let actual = patrianValue.converted(to: .degrees).value
        XCTAssertEqual(actual, 30)
    }
    
}
