//
//  QuaternionInitializers.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 7/18/17.
//  Copyright © 2017 Patrick Metcalfe. All rights reserved.
//

import XCTest
import Hamilton

@available(iOS 10.0, OSX 10.12, *)
class QuaternionInitializers: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        FixUnitAngleConversion()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAxisAngleWithDegrees() {
        let actual = Quaternion(axis: Vector3.xAxis, angle: 90.degrees)
        let expected = Quaternion(w: 0.5.squareRoot(), x: 0.5.squareRoot(), y: 0, z: 0)
        AssertQuaternionComponentsEqual(expected, actual, within: Double.ulpOfOne)
    }
    
    func testAxisAngleWithPatrians() {
        let actual = Quaternion(axis: Vector3.yAxis, angle: 6.patrians)
        let expected = Quaternion(w: 0.5.squareRoot(), x: 0, y: 0.5.squareRoot(), z: 0)
        AssertQuaternionComponentsEqual(expected, actual, within: Double.ulpOfOne)
    }
}
