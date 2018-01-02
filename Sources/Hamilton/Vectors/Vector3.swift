//
//  Vector3.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

public struct Vector3 : Vectorable {
    
    public static let xAxis = Vector3(1, 0, 0)
    public static let yAxis = Vector3(0, 1, 0)
    public static let zAxis = Vector3(0, 0, 1)
    
    public static let zero = Vector3(x: 0, y: 0, z: 0)
    
    public typealias Size = ThreeDegreesOfFreedom
    public typealias Component = Float
    
    public let x : Component
    public let y : Component
    public let z : Component
    
    public var components : [Component] {
        return [x, y, z]
    }
    
    public init(_ x : Component, _ y : Component, _ z : Component) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(x : Component, y : Component, z : Component) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func dotting(_ other : Vector3) -> Component {
        return (x * other.x) + (y * other.y) + (z * other.z)
    }
    
    public func adding(_ other : Vector3) -> Vector3 {
        let newx = x + other.x
        let newy = y + other.y
        let newz = z + other.z
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func subtracted(by other : Vector3) -> Vector3 {
        let newx = x - other.x
        let newy = y - other.y
        let newz = z - other.z
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func multiplying(scalar other : Component) -> Vector3 {
        let newx = x * other
        let newy = y * other
        let newz = z * other
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func dividing(scalar other : Component) -> Vector3 {
        return multiplying(scalar: 1 / other)
    }
    
    public func multiplied(by other : Vector3) -> Vector3 {
        let newx = x * other.x
        let newy = y * other.y
        let newz = z * other.z
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func divided(by other : Vector3) -> Vector3 {
        let newx = x / other.x
        let newy = y / other.y
        let newz = z / other.z
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func normalized() -> Vector3 {
        return self.multiplying(scalar: 1 / magnitude)
    }
    
    public func crossing(with other : Vector3) -> Vector3 {
        let newx = (self.y * other.z) - (self.z * other.y)
        let newy = (self.z * other.x) - (self.x * other.z)
        let newz = (self.x * other.y) - (self.y * other.x)
        return Vector3(x: newx, y: newy, z: newz)
    }
    
    public func isOrthogonal(to other : Vector3) -> Bool {
        return dotting(other) == 0
    }
    
    
}

extension Vector3 : Equatable {}
public func ==(_ rhs : Vector3, _ lhs : Vector3) -> Bool {
    return rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
}

public func +(_ lhs : Vector3, _ rhs : Vector3) -> Vector3 {
    return lhs.adding(rhs)
}

public func -(_ lhs : Vector3, _ rhs : Vector3) -> Vector3 {
    return lhs.subtracted(by: rhs)
}
