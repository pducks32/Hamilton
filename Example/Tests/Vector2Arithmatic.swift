//
//  Vector2Arithmatic.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Hamilton

class Vector2Arithmatic: XCTestCase {
    let alpha = Vector2(x: 1, y: 2)
    let beta = Vector2(x: 8, y: 10)
    
    func testAddition() {
        let result = alpha.adding(beta)
        let answer = Vector2(x: 9, y: 12)
        XCTAssertEqual(result, answer)
    }
    
    func testSubtraction() {
        let result = alpha.subtracted(by: beta)
        let answer = Vector2(x: -7, y: -8)
        XCTAssertEqual(result, answer)
    }
    
    func testDotProduct() {
        let result = alpha.dotting(beta)
        let answer = Vector2.Component(28)
        XCTAssertEqual(result, answer)
    }
    
    func testScalarMultipication() {
        let result = alpha.multiplying(scalar: 4)
        let answer = Vector2(x: 4, y: 8)
        XCTAssertEqual(result, answer)
    }
    
    func testScalarDivision() {
        let result = alpha.dividing(scalar: 2)
        let answer = Vector2(x: 1/2, y: 1)
        XCTAssertEqual(result, answer)
    }
    
    func testVectorMultipication() {
        let result = alpha.multiplied(by: beta)
        let answer = Vector2(x: 8, y: 20)
        XCTAssertEqual(result, answer)
    }
    
    func testVectorDivision() {
        let result = alpha.divided(by: beta)
        let answer = Vector2(x: 1/8, y: 1/5)
        XCTAssertEqual(result, answer)
        
        let resultReverse = alpha.divided(from: beta)
        let answerReverse = Vector2(x: 8, y: 5)
        XCTAssertEqual(resultReverse, answerReverse)
    }
    
    func testNormalization() {
        let result = alpha.normalized()
        let answer = Vector2(x: 1 / sqrt(5), y: 2 / sqrt(5))
        XCTAssertEqual(result, answer)
    }
    
    func testZeroIsZero() {
        let result = Vector2.zero
        let answer = Vector2(x: 0, y: 0)
        XCTAssertEqual(result, answer)
    }
    
}
