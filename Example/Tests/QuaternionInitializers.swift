//
//  QuaternionInitializers.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 7/18/17.
//  Copyright © 2017 Patrick Metcalfe. All rights reserved.
//

import XCTest
import Hamilton

func AssertQuaternionEqual(_ expected : Quaternion, _ actual : Quaternion, within accuracy : Double = 0, file : StaticString = #file, line : UInt = #line) {
    let differenceMagnitude = actual.subtracted(by: expected).magnitude
    XCTAssertLessThanOrEqual(differenceMagnitude, accuracy, "No", file: file, line: line)
}

func formatFailureMessage(component : String, expected : Quaternion.Component, actual : Quaternion.Component, accuracy : Double) -> String {
    return "Component \(component) of expected (\(expected) is not within \(accuracy) of actual (\(actual))"
}

func AssertQuaternionComponentsEqual(_ expected : Quaternion, _ actual : Quaternion, within accuracy : Double = 0, file : StaticString = #file, lineno : UInt = #line) {
    zip(["w", "x", "y", "z"], zip(expected.components, actual.components)).forEach { (componentName, components) in
        let (expectedComponent, actualComponent) = components
        XCTAssertEqual(expectedComponent, actualComponent, accuracy: accuracy, formatFailureMessage(component: componentName, expected: expectedComponent, actual: actualComponent, accuracy: accuracy), file: file, line: lineno)
    }
}

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
