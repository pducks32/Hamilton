//
//  EulerAnglesSystemConversionTests.swift
//  HamiltonTests
//
//  Created by Patrick Metcalfe on 1/13/18.
//

import XCTest
@testable import Hamilton

@available(OSX 10.12, *)
func AssetEulerAnglesExactlyMatchs(_ actual : EulerAngles, expected : EulerAngles, file : StaticString = #file, line : UInt = #line) {
    XCTAssertEqual(actual.pitch, expected.pitch, file: file, line: line)
    XCTAssertEqual(actual.yaw, expected.yaw, file: file, line: line)
    XCTAssertEqual(actual.roll, expected.roll, file: file, line: line)
    XCTAssertEqual(actual.system, expected.system, file: file, line: line)
}

@available(OSX 10.12, *)
class EulerAnglesSystemConversionTests: XCTestCase {
    func testConvertToXYZ() {
        let firstRotation = 22.degrees
        let secondRotation = 14.degrees
        let thirdRotation = 122.degrees
        
        let expected = EulerAngles(pitch: firstRotation, yaw: secondRotation, roll: thirdRotation, system: .xyz)
        
        // EulerAngles.System.xyz
        let xyz = EulerAngles(pitch: firstRotation, yaw: secondRotation, roll: thirdRotation, system: .xyz)
        AssetEulerAnglesExactlyMatchs(xyz.convertedSystem(to: .xyz), expected: expected)
        
        // EulerAngles.System.xzy
        let xzy = EulerAngles(pitch: firstRotation, yaw: thirdRotation, roll: secondRotation, system: .xzy)
        AssetEulerAnglesExactlyMatchs(xzy.convertedSystem(to: .xyz), expected: expected)
        
        // EulerAngles.System.yxz
        let yxz = EulerAngles(pitch: secondRotation, yaw: firstRotation, roll: thirdRotation, system: .yxz)
        AssetEulerAnglesExactlyMatchs(yxz.convertedSystem(to: .xyz), expected: expected)
        
        // EulerAngles.System.yzx
        let yzx = EulerAngles(pitch: secondRotation, yaw: thirdRotation, roll: firstRotation, system: .yzx)
        AssetEulerAnglesExactlyMatchs(yzx.convertedSystem(to: .xyz), expected: expected)
        
        // EulerAngles.System.zxy
        let zxy = EulerAngles(pitch: thirdRotation, yaw: firstRotation, roll: secondRotation, system: .zxy)
        AssetEulerAnglesExactlyMatchs(zxy.convertedSystem(to: .xyz), expected: expected)
        
        // EulerAngles.System.zyx
        let zyx = EulerAngles(pitch: thirdRotation, yaw: secondRotation, roll: firstRotation, system: .zyx)
        AssetEulerAnglesExactlyMatchs(zyx.convertedSystem(to: .xyz), expected: expected)
    }
    
    func testConvertToYZX() {
        let firstRotation = 22.degrees
        let secondRotation = 14.degrees
        let thirdRotation = 122.degrees
        
        let expected = EulerAngles(pitch: secondRotation, yaw: thirdRotation, roll: firstRotation, system: .yzx)
        
        // EulerAngles.System.xyz
        let xyz = EulerAngles(pitch: firstRotation, yaw: secondRotation, roll: thirdRotation, system: .xyz)
        AssetEulerAnglesExactlyMatchs(xyz.convertedSystem(to: .yzx), expected: expected)
        
        // EulerAngles.System.xzy
        let xzy = EulerAngles(pitch: firstRotation, yaw: thirdRotation, roll: secondRotation, system: .xzy)
        AssetEulerAnglesExactlyMatchs(xzy.convertedSystem(to: .yzx), expected: expected)
        
        // EulerAngles.System.yxz
        let yxz = EulerAngles(pitch: secondRotation, yaw: firstRotation, roll: thirdRotation, system: .yxz)
        AssetEulerAnglesExactlyMatchs(yxz.convertedSystem(to: .yzx), expected: expected)
        
        // EulerAngles.System.yzx
        let yzx = EulerAngles(pitch: secondRotation, yaw: thirdRotation, roll: firstRotation, system: .yzx)
        AssetEulerAnglesExactlyMatchs(yzx.convertedSystem(to: .yzx), expected: expected)
        
        // EulerAngles.System.zxy
        let zxy = EulerAngles(pitch: thirdRotation, yaw: firstRotation, roll: secondRotation, system: .zxy)
        AssetEulerAnglesExactlyMatchs(zxy.convertedSystem(to: .yzx), expected: expected)
        
        // EulerAngles.System.zyx
        let zyx = EulerAngles(pitch: thirdRotation, yaw: secondRotation, roll: firstRotation, system: .zyx)
        AssetEulerAnglesExactlyMatchs(zyx.convertedSystem(to: .yzx), expected: expected)
    }
}
