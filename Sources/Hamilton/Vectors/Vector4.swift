//
//  Vector4.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

public struct Vector4 : Vectorable {
    public typealias Size = FourDegreesOfFreedom
    public typealias Component = Float
    
    public static let zero = Vector4(w: 0, x: 0, y: 0, z: 0)
    
    public let w : Component
    public let x : Component
    public let y : Component
    public let z : Component
    
    public var components : [Component] {
        return [w, x, y, z]
    }
    
    public init(w : Component, x : Component, y : Component, z : Component) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func dotting(_ other : Vector4) -> Component {
        return sqrt((w * other.w) + (x * other.x) + (y * other.y) + (z * other.z))
    }
    
    public func adding(_ other : Vector4) -> Vector4 {
        let neww = w + other.w
        let newx = x + other.x
        let newy = y + other.y
        let newz = z + other.z
        return Vector4(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func subtracted(by other : Vector4) -> Vector4 {
        let neww = w - other.w
        let newx = x - other.x
        let newy = y - other.y
        let newz = z - other.z
        return Vector4(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func multiplying(scalar other : Component) -> Vector4 {
        let neww = w * other
        let newx = x * other
        let newy = y * other
        let newz = z * other
        return Vector4(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func dividing(scalar other : Component) -> Vector4 {
        return multiplying(scalar: 1 / other)
    }
    
    public func multiplied(by other : Vector4) -> Vector4 {
        let neww = w * other.w
        let newx = x * other.x
        let newy = y * other.y
        let newz = z * other.z
        return Vector4(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func divided(by other : Vector4) -> Vector4 {
        let neww = w / other.w
        let newx = x / other.x
        let newy = y / other.y
        let newz = z / other.z
        return Vector4(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func normalized() -> Vector4 {
        return self.multiplying(scalar: 1 / magnitude)
    }
}

extension Vector4 : Equatable {}
public func ==(_ rhs : Vector4, _ lhs : Vector4) -> Bool {
    return rhs.w == lhs.w && rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
}
