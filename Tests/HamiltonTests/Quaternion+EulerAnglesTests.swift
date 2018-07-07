//
//  Quaternion+EulerAnglesTests.swift
//  HamiltonTests
//
//  Created by Patrick Metcalfe on 6/26/18.
//

import XCTest
@testable import Hamilton

@available(OSX 10.12, *)
class Quaternion_EulerAnglesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAgainstPyUtils() {
        let quaternion = Quaternion(w: 0.0490105375647545, x: -0.0174177940934896, y: 0.998337149620056, z: 0.0248466618359089)
        let eulerAngles = quaternion.convertedToEulerAngles(system: .zyx).converted(to: .degrees)
        
        let fromUtilsVector = Vector3(177.24079741039458, 5.665676094324404, -178.1375049207774)
        let fromUtils = EulerAngles(vectorOfAngles: fromUtilsVector, unit: .degrees, system: .zyx)
        
        XCTAssertEqual(fromUtils.pitch, eulerAngles.pitch)
        XCTAssertEqual(fromUtils.yaw, eulerAngles.yaw)
        XCTAssertEqual(fromUtils.roll, eulerAngles.roll)
        
        let difference = fromUtils.componentwiseDifferenceTo(eulerAngles)
        let differenceVector = Vector3(difference.pitch.value, difference.yaw.value, difference.roll.value)
        AssertVector3ComponentsEqual(.zero, differenceVector, within: .ulpOfOne)
    }
}
