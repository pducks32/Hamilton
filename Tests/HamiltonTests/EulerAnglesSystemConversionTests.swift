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
    
    func testFromRuntimeChecking() {
        let startQuaternion = Quaternion(w: 0.34817538, x: 0.3857909, y: 0.85275203, z: -0.052471627)
        let endQuaternion = Quaternion(w: 0.8553054, x: 0.0071712844, y: 0.5174541, z: -0.025346993)
        let change = Quaternion(w: 0.7389459935527631, x: -0.344469427913271, y: -0.5295440985960993, z: 0.23427052628845318)
        
        let betweenThem = startQuaternion.multiplied(by: endQuaternion.inverse)
        let awayFromStart = startQuaternion.multiplied(by: change)
        let awayFromRotation = change.multiplied(by: awayFromStart)
        
        let backFromAwayFromStart = awayFromStart.multiplied(by: endQuaternion.inverse)
        let backFromAwayFromRotation = endQuaternion.inverse.multiplied(by: awayFromRotation)
        
        print(betweenThem)
        print(awayFromStart)
        print(awayFromRotation)
        print(backFromAwayFromStart)
        print(backFromAwayFromRotation)
        print("Break")
        print(endQuaternion.multiplied(by: change.inverse))
        print(endQuaternion.premultiplied(by: change.inverse))
        
        print(endQuaternion.multiplied(by: change))
        print(endQuaternion.premultiplied(by: change.inverse))
        
        print(endQuaternion.inverse.multiplied(by: change.inverse))
        print(endQuaternion.inverse.premultiplied(by: change.inverse))
        print(endQuaternion.inverse.multiplied(by: change))
        print(endQuaternion.inverse.premultiplied(by: change.inverse))
    }
    
    func testThatWeAreWorking() {
        let q = Quaternion(w: -0.41991835676895145, x: -0.7558346735139579, y: -0.08143371987999137, z: 0.49573296596179006)
        let startEuler = q.asEulerAngles.converted(to: .degrees)
        
        let rotateX = Quaternion(between: Vector3.yAxis, and: Vector3.zAxis)
        let rotated = rotateX.multiplied(by: q).multiplied(by: rotateX.inverse)
        let rotatedB = q.multiplied(by: rotateX).multiplied(by: q.inverse)
        let rotatedC = rotateX.multiplied(by: q)
        let rotatedD = rotateX.inverse.multiplied(by: q)
        
        let endEulerA = rotated.asEulerAngles.converted(to: .degrees)
        let endEulerB = rotatedB.asEulerAngles.converted(to: .degrees)
        let endEulerC = rotatedC.asEulerAngles.converted(to: .degrees)
        let endEulerD = rotatedD.asEulerAngles.converted(to: .degrees)
        
        print(endEulerA)
        print(endEulerB)
        print(endEulerC)
        print(endEulerD)
        print(startEuler)
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
