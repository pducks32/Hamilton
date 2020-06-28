//
//  QuaternionInitializers.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 7/18/17.
//  Copyright © 2017 Patrick Metcalfe. All rights reserved.
//

import XCTest
import Hamilton

func XCTAssetCloseTo<X : FloatingPoint>(_ expected : X, actual : X, closerThan : X, file : StaticString = #filePath, line : UInt = #line) {
    let distance = abs(actual - expected)
    XCTAssertLessThan(distance, closerThan, file: file, line: line)
}

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
    
    func testClosenessFromOnlineCalculator() {
        let euler = EulerAngles(pitch: 91.860.degrees, yaw: 33.770.degrees, roll: (-111.272).degrees)
        let quat = Quaternion(w: 0.548, x: 0.221, y: 0.682, z: -0.432)
        let eulerAsQuat = Quaternion(eulerAngles: euler)
        AssertQuaternionComponentsEqual(quat, eulerAsQuat, within: 0.0005)
    }
    
    func testQuaternionIsReversible() {
        let eulerAngles = EulerAngles(pitch: 45.degrees, yaw: 1.degrees, roll: 16.degrees, system: .yzx)
        let quaternion = Quaternion(eulerAngles: eulerAngles)
        let reversedEulerAngles = quaternion.asEulerAngles.converted(to: .degrees)
        print(eulerAngles.componentwiseDifferenceTo(reversedEulerAngles))

        print(0.00833329622496489.radians.converted(to: .degrees).value)
        print(eulerAngles.converted(to: .radians).componentwiseDifferenceTo(quaternion.asEulerAngles))
        XCTAssertEqual(eulerAngles.converted(to: .radians), quaternion.asEulerAngles)
        XCTAssertEqual(eulerAngles, reversedEulerAngles)
    }
}
