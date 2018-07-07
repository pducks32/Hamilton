//
//  Vector4.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

/// W first 4 vector.
public struct Vector4 : Vectorable {
    public typealias Size = FourDegreesOfFreedom
    public typealias Component = Float
    
    /// 4D origin
    public static let zero = Vector4(w: 0, x: 0, y: 0, z: 0)
    
    /// First component of vector
    public let w : Component
    /// Second component of vector
    public let x : Component
    /// Third component of vector
    public let y : Component
    /// Fourth component of vector
    public let z : Component
    
    public var components : [Component] {
        return [w, x, y, z]
    }
    
    public init(_ elements: Component...) {
        w = elements[0]
        x = elements[1]
        y = elements[2]
        z = elements[3]
    }
    
    public init(w : Component, x : Component, y : Component, z : Component) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
    
    public var negated: Vector4 {
        return Vector4(w: -w, x: -x, y: -y, z: -z)
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
extension Vector4 : Codable {}
extension Vector4 : Equatable {}
public func ==(_ rhs : Vector4, _ lhs : Vector4) -> Bool {
    return rhs.w == lhs.w && rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
}
