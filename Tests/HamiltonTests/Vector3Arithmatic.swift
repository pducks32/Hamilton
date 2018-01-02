//
//  Vector3Arithmatic.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Hamilton

class Vector3Arithmatic: XCTestCase {
    let alpha = Vector3(1, 2, 3)
    let beta = Vector3(x: 8, y: 10, z: 3.5)
    
    func testAddition() {
        let result = alpha.adding(beta)
        let answer = Vector3(x: 9, y: 12, z: 6.5)
        XCTAssertEqual(result, answer)
    }
    
    func testSubtraction() {
        let result = alpha.subtracted(by: beta)
        let answer = Vector3(x: -7, y: -8, z: -0.5)
        XCTAssertEqual(result, answer)
    }
    
    func testDotProduct() {
        let result = alpha.dotting(beta)
        let answer = Vector3.Component(38.5)
        XCTAssertEqual(result, answer)
    }
    
    func testScalarMultipication() {
        let result = alpha.multiplying(scalar: 2.5)
        let answer = Vector3(x: 2.5, y: 5, z: 7.5)
        XCTAssertEqual(result, answer)
    }
    
    func testScalarDivision() {
        let result = alpha.dividing(scalar: 2)
        let answer = Vector3(x: 1/2, y: 1, z: 3/2)
        XCTAssertEqual(result, answer)
    }
    
    func testVectorMultipication() {
        let result = alpha.multiplied(by: beta)
        let answer = Vector3(x: 8, y: 20, z: 10.5)
        XCTAssertEqual(result, answer)
    }
    
    func testVectorDivision() {
        let result = alpha.divided(by: beta)
        let answer = Vector3(x: 1/8, y: 1/5, z: 6/7)
        XCTAssertEqual(result, answer)
        
        let resultReverse = alpha.divided(from: beta)
        let answerReverse = Vector3(x: 8, y: 5, z: 7/6)
        XCTAssertEqual(resultReverse, answerReverse)
    }
    
    func testNormalization() {
        let result = alpha.normalized()
        let answer = Vector3(x: 1 / sqrt(14), y: 2 / sqrt(14), z: 3 / sqrt(14))
        XCTAssertEqual(result, answer)
    }
    
    func testIsOrthogonal() {
        let result = Vector3(1, 0, 0).isOrthogonal(to: Vector3(0, 1, 0))
        XCTAssertTrue(result)
    }
    
    func testCrossProductIsOrthogonal() {
        let result = alpha.crossing(with: beta)
        XCTAssertTrue(result.isOrthogonal(to: alpha))
        XCTAssertTrue(result.isOrthogonal(to: beta))
    }
    
    func testCrossProductOfSelfIsZero() {
        let result = alpha.crossing(with: alpha)
        XCTAssertEqual(result, Vector3(0, 0, 0))
    }
    
    func testZeroIsZero() {
        let result = Vector3.zero
        let answer = Vector3(0, 0, 0)
        XCTAssertEqual(result, answer)
    }
}
