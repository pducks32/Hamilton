//
//  Vector2.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

public struct Vector2 : Vectorable {
    
    public typealias Size = TwoDegreesOfFreedom
    public typealias Component = Float
    
    /// 2D origin
    public static let zero = Vector2(x: 0, y: 0)
    
    /// First component of vector
    public let x : Component
    /// Second component of vector
    public let y : Component
    
    public var components : [Component] {
        return [x, y]
    }
    
    public init(_ elements: Component...) {
        x = elements[0]
        y = elements[1]
    }
    
    public init(x : Component, y : Component) {
        self.x = x
        self.y = y
    }
    
    public var negated: Vector2 {
        return Vector2(x: -x, y: -y)
    }
    
    public func dotting(_ other : Vector2) -> Component {
        return (x * other.x) + (y * other.y)
    }
    
    public func adding(_ other : Vector2) -> Vector2 {
        let newx = x + other.x
        let newy = y + other.y
        return Vector2(x: newx, y: newy)
    }
    
    public func subtracted(by other : Vector2) -> Vector2 {
        let newx = x - other.x
        let newy = y - other.y
        return Vector2(x: newx, y: newy)
    }
    
    public func multiplying(scalar other : Component) -> Vector2 {
        let newx = x * other
        let newy = y * other
        return Vector2(x: newx, y: newy)
    }
    
    public func dividing(scalar other : Component) -> Vector2 {
        return multiplying(scalar: 1 / other)
    }
    
    public func multiplied(by other : Vector2) -> Vector2 {
        let newx = x * other.x
        let newy = y * other.y
        return Vector2(x: newx, y: newy)
    }
    
    public func divided(by other : Vector2) -> Vector2 {
        let newx = x / other.x
        let newy = y / other.y
        return Vector2(x: newx, y: newy)
    }
    
    public func normalized() -> Vector2 {
        return self.multiplying(scalar: 1 / magnitude)
    }
}
extension Vector2 : Codable {}
extension Vector2 : Equatable {}
public func ==(_ rhs : Vector2, _ lhs : Vector2) -> Bool {
    return rhs.x == lhs.x && rhs.y == lhs.y
}
