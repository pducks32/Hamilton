//
//  Rotateable.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 7/18/17.
//

import Foundation
import simd

public protocol Rotateable {
    mutating func rotate(by quaternion : Quaternion)
    func rotating(by quaternion : Quaternion) -> Self
    
    @available(iOS 10.0, OSX 10.12, *)
    mutating func rotate(by eulerAngles : EulerAngles)
    @available(iOS 10.0, OSX 10.12, *)
    func rotating(by eulerAngles : EulerAngles) -> Self
}

public extension Rotateable {
    mutating func rotate(by quaternion : Quaternion) {
        self = rotating(by: quaternion)
    }
    @available(iOS 10.0, OSX 10.12, *)
    mutating func rotate(by eulerAngles : EulerAngles) {
        self = rotating(by: eulerAngles)
    }
    @available(iOS 10.0, OSX 10.12, *)
    func rotating(by eulerAngles : EulerAngles) -> Self {
        return rotating(by: Quaternion(eulerAngles: eulerAngles))
    }
}

extension Vector3 : Rotateable {
    public func rotating(by quaternion : Quaternion) -> Vector3 {
        let selfAsQuat = Quaternion(w: Quaternion.Component(0), x: Quaternion.Component(x), y: Quaternion.Component(y), z: Quaternion.Component(z))
        let rotateQuat = quaternion.multiplied(by: selfAsQuat).multiplied(by: quaternion.inverse)
        return Vector3(Vector3.Component(rotateQuat.x), Vector3.Component(rotateQuat.y), Vector3.Component(rotateQuat.z))
    }
}
