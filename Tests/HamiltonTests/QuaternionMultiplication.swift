//
//  QuaternionMultiplication.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 8/25/17.
//  Copyright © 2017 Patrick Metcalfe. All rights reserved.
//

import XCTest
@testable import Hamilton

class QuaternionMultiplication: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRotatingVectorBy90() {
        let rotateXBy90 = Quaternion(axis: .xAxis, degrees: 90)
        let rotateYBy90 = Quaternion(axis: .yAxis, degrees: 90)
        let rotateZBy90 = Quaternion(axis: .zAxis, degrees: 90)
        
        let baseVector = Vector3(0, 0, 1)
        
        let shouldBySimpleNegativeYVector = baseVector.rotated(by: rotateXBy90)
        AssertVector3ComponentsEqual(shouldBySimpleNegativeYVector, Vector3(0, -1, 0))
        
        let shouldStayTheSame = shouldBySimpleNegativeYVector.rotated(by: rotateYBy90)
        AssertVector3ComponentsEqual(shouldStayTheSame, shouldBySimpleNegativeYVector)
        
        let shouldBeSimpleXVector = shouldStayTheSame.rotated(by: rotateZBy90)
        AssertVector3ComponentsEqual(shouldBeSimpleXVector, Vector3(1, 0, 0))
    }
    
    func testCombinedMultipication() {
        let rotateXBy90 = Quaternion(axis: .xAxis, degrees: 90)
        let rotateYBy90 = Quaternion(axis: .yAxis, degrees: 90)
        let rotateZBy90 = Quaternion(axis: .zAxis, degrees: 90)
        
        let baseVector = Vector3(0, 0, 1)
        
        let completeTurn = rotateXBy90.multiplied(by: rotateYBy90).multiplied(by: rotateZBy90)
        
        let shouldBeSimpleXVector = baseVector.rotated(by: completeTurn)
        AssertVector3ComponentsEqual(shouldBeSimpleXVector, Vector3(1, 0, 0))
    }
    
    func testRotatingIsCounterclockwise() {
        let baseVector = Vector3(0, 0, 1)
        
        let shouldBySimpleNegativeYVector = baseVector.rotated(by: Quaternion(axis: .xAxis, degrees: 90))
        AssertVector3ComponentsEqual(shouldBySimpleNegativeYVector, Vector3(0, -1, 0))
    }
    
    func testRotatingIsNotClockwise() {
        let baseVector = Vector3(0, 0, 1)
        
        let shouldBySimpleNegativeYVector = baseVector.rotated(by: Quaternion(axis: .xAxis, degrees: 90))
        AssertVector3ComponentsNotEqual(shouldBySimpleNegativeYVector, Vector3(0, 1, 0))
    }
}
