//
//  Rotateable.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 7/18/17.
//

import Foundation
import simd

/// Implemented by types that can be rotated
/// - Todo: Implement a reverse protocol for Rotaters
public protocol Rotateable {
    // MARK: Quaternion
    
    /// Rotates `self` by `quaternion`
    mutating func rotate(by quaternion : Quaternion)
    /// Returns new `Self` by rotating `self` by `quaternion`
    func rotated(by quaternion : Quaternion) -> Self
    
    // MARK: EulerAngles
    
    /// Rotates `self` by `eulerAngles`
    @available(iOS 10.0, OSX 10.12, *)
    mutating func rotate(by eulerAngles : EulerAngles)
    
    /// Returns new `Self` by rotating `self` by `eulerAngles`
    /// - Todo: Implement with `EulerAngles` to reduce quaternion
    /// conversion's errors
    @available(iOS 10.0, OSX 10.12, *)
    func rotated(by eulerAngles : EulerAngles) -> Self
}

public extension Rotateable {
    mutating func rotate(by quaternion : Quaternion) {
        self = rotated(by: quaternion)
    }
    @available(iOS 10.0, OSX 10.12, *)
    mutating func rotate(by eulerAngles : EulerAngles) {
        self = rotated(by: eulerAngles)
    }
    @available(iOS 10.0, OSX 10.12, *)
    func rotated(by eulerAngles : EulerAngles) -> Self {
        return rotated(by: Quaternion(eulerAngles: eulerAngles))
    }
}

extension Vector3 : Rotateable {
    /// Rotates Vector by `quaternion`
    ///
    /// Converts vector into a quaternion (p) multiplies and then conjugates by quaternion.
    public func rotated(by quaternion : Quaternion) -> Vector3 {
        let selfAsQuat = Quaternion(w: Quaternion.Component(0), x: Quaternion.Component(x), y: Quaternion.Component(y), z: Quaternion.Component(z))
        let rotateQuat = quaternion.multiplied(by: selfAsQuat).multiplied(by: quaternion.inverse)
        return Vector3(Component(rotateQuat.x), Component(rotateQuat.y), Component(rotateQuat.z))
    }
}
