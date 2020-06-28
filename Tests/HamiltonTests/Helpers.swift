//
//  Helpers.swift
//  Hamilton_Tests
//
//  Created by Patrick Metcalfe on 8/25/17.
//  Copyright © 2017 Patrick Metcalfe. All rights reserved.
//

import XCTest
@testable import Hamilton

func AssertVector3ComponentsEqual(_ expected : Vector3, _ actual : Vector3, within accuracy : Vector3.Component = .ulpOfOne, file : StaticString = #filePath, lineno : UInt = #line) {
    zip(["x", "y", "z"], zip(expected.components, actual.components)).forEach { (componentName, components) in
        let (expectedComponent, actualComponent) = components
        XCTAssertEqual(expectedComponent, actualComponent, accuracy: accuracy, formatFailureMessage(component: componentName, expected: expectedComponent, actual: actualComponent, accuracy: accuracy), file: file, line: lineno)
    }
}

func AssertVector3ComponentsNotEqual(_ expected : Vector3, _ actual : Vector3, within accuracy : Vector3.Component = .ulpOfOne, numberOfComponentsNotEqual : Int = 1, file : StaticString = #filePath, lineno : UInt = #line) {
    let doComponentsExceedLimit = zip(expected.components, actual.components).map({ (components) -> Bool in
        let (expectedComponent, actualComponent) = components
        let distanceFromOneToTheOther = expectedComponent.distance(to: actualComponent).magnitude
        return distanceFromOneToTheOther >= accuracy
    })
    
    let numberOfComponentsExceedingLimit = doComponentsExceedLimit.filter({ $0 == true }).count
    
    XCTAssert(numberOfComponentsExceedingLimit <= numberOfComponentsNotEqual, "Components not matching (count: \(numberOfComponentsExceedingLimit)) is less than allowed (\(numberOfComponentsNotEqual))", file: file, line: lineno)
}

func AssertQuaternionEqual(_ expected : Quaternion, _ actual : Quaternion, within accuracy : Double = 0, file : StaticString = #filePath, line : UInt = #line) {
    let differenceMagnitude = actual.subtracted(by: expected).magnitude
    XCTAssertLessThanOrEqual(differenceMagnitude, accuracy, "No", file: file, line: line)
}

func formatFailureMessage<FloatingLike : FloatingPoint>(component : String, expected : FloatingLike, actual : FloatingLike, accuracy : FloatingLike, notEqual : Bool = false) -> String {
    let descriptor = notEqual ? "" : "not"
    return "Component \(component) of expected (\(expected)) is \(descriptor) within \(accuracy) of actual (\(actual))"
}

func AssertQuaternionComponentsEqual(_ expected : Quaternion, _ actual : Quaternion, within accuracy : Double = 0, file : StaticString = #filePath, lineno : UInt = #line) {
    zip(["w", "x", "y", "z"], zip(expected.components, actual.components)).forEach { (componentName, components) in
        let (expectedComponent, actualComponent) = components
        XCTAssertEqual(expectedComponent, actualComponent, accuracy: accuracy, formatFailureMessage(component: componentName, expected: expectedComponent, actual: actualComponent, accuracy: accuracy), file: file, line: lineno)
    }
}
