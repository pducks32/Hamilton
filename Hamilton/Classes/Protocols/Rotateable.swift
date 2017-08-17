//
//  Rotateable.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 7/18/17.
//

import Foundation
import simd

public protocol Rotateable {
    mutating func rotate(by quaternion : Quaternion, around origin : Self)
    func rotating(by quaternion : Quaternion, around origin : Self) -> Self
}

public extension Rotateable {
    mutating func rotate(by quaternion : Quaternion, around origin : Self) {
        self = rotating(by: quaternion, around: origin)
    }
}

extension Vector3 : Rotateable {
    mutating public func rotate(by quaternion : Quaternion, around origin : Vector3 = .zero) {
        self = rotating(by: quaternion, around: origin)
    }
    
    public func rotating(by quaternion: Quaternion, around origin : Vector3 = .zero) -> Vector3 {
        let myQuat = _simd_quaternion(simd_double3(quaternion.x, quaternion.y, quaternion.z), quaternion.w)
        let result = myQuat.act(simd_double3(Double(x), Double(y), Double(z)))
        return Vector3(Vector3.Component(result.x), Vector3.Component(result.y), Vector3.Component(result.z))
    }
}
