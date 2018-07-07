//
//  Vectorable.swift
//  Pods
//
//  Created by Patrick Metcalfe on 10/20/16.
//
//

import Foundation

/// The number of components in the vector
/// - Todo: Implement a better system that provides
/// protocol benefits for other implementations besides
/// Hamilton's ones.
public protocol DegreesOfFreedom { }
public struct FourDegreesOfFreedom : DegreesOfFreedom {}
public struct ThreeDegreesOfFreedom : DegreesOfFreedom {}
public struct TwoDegreesOfFreedom : DegreesOfFreedom {}

public protocol Vectorable {
    /// The number of components in the vector
    associatedtype Size : DegreesOfFreedom
    /// The data type stored in it's components
    associatedtype Component : Scalar
    
    /// Create new `Self` with ordered `Component`s
    init(_ elements : Component...)
    
    /// The components in order
    var components : [Component] { get }
    
    /// The euclidean distance among the components to the field's origin
    var magnitude : Component { get }
    
    /// Return negative of all components
    var negated : Self { get }
    /// Negates all components
    mutating func negate()
    
    /// Inner product with `other`
    func dotting(_ other : Self) -> Component
    
    /// Component wise add with `other`
    mutating func add(_ other : Self)
    /// Component wise add with `other` into new `Self`
    func adding(_ other : Self) -> Self
    
    /// Component wise subtract by `other` (`self` - `other`)
    mutating func subtract(by other : Self)
    /// Component wise subtract by `other` into new `Self` (`self` - `other`)
    func subtracted(by other : Self) -> Self
    
    /// Component wise subtract by `other` (`other` - `self`)
    mutating func subtract(from other : Self)
    /// Component wise subtract by `other` into new `Self` (`other` - `self`)
    func subtracted(from other : Self) -> Self
    
    /// Multiply each component by scalar
    mutating func multiply(scalar other : Component)
    /// Multiply each component by scalar into new `Self`
    func multiplying(scalar other : Component) -> Self
    
    /// Divide each component by scalar
    mutating func divide(scalar other : Component)
    /// Divide each component by scalar into new `Self`
    func dividing(scalar other : Component) -> Self
    
    /// Component wise multiply with `other`
    mutating func multiply(by other : Self)
    /// Component wise multiply with `other` into new `Self`
    func multiplied(by other : Self) -> Self
    
    /// Component wise divide by `other` (self / other)
    mutating func divide(by other : Self)
    /// Component wise divide by `other` into new `Self` (self / other)
    func divided(by other : Self) -> Self
    
    /// Component wise divide by `self` (other / self)
    mutating func divide(from other : Self)
    /// Component wise divide by `self` into new `Self` (other / self)
    func divided(from other : Self) -> Self
    
    /// Scale components until magnitude is 1
    mutating func normalize()
    /// Scale components until magnitude is 1 into new `Self`
    func normalized() -> Self
}

extension Vectorable {
    public static prefix func -(_ v : Self) -> Self {
        return v.negated
    }
}

extension Vectorable where Size == ThreeDegreesOfFreedom {
    /// Exterior product with `other` into new `Self`
    /// - Note: Noncommunative
    public func crossing(with other : Self) -> Self {
        let u = self.components
        let v = other.components
        // u x v
        let iComponent = u[1]*v[2] - u[2]*v[1]
        let jComponent = u[2]*v[0] - u[0]*v[2]
        let kComponent = u[0]*v[1] - u[1]*v[0]
        return Self(iComponent, jComponent, kComponent)
    }
    
    /// Exterior product with `other`
    /// - Note: Noncommunative
    public mutating func cross(with other : Self) {
        self = self.crossing(with: other)
    }
}

extension Vectorable where Component == Float {
    public var magnitude : Float {
        let squaredValues : [Float] = components.map({ $0 * $0 })
        let squaredMagnitude = squaredValues.reduce(Float(0), { $0 + $1 })
        return sqrt(squaredMagnitude)
    }
}

extension Vectorable where Component == Double {
    public var magnitude : Double {
        let squaredMagnitude = components.map({ $0 * $0 }).reduce(Double(0), { $0 + $1 })
        return sqrt(squaredMagnitude)
    }
}

extension Vectorable {
    
    public mutating func add(_ other : Self) {
        self = self.adding(other)
    }
    
    public mutating func negate() {
        self = self.negated
    }
    
    mutating public func subtract(by other : Self) {
        self = self.subtracted(by: other)
    }
    
    public func subtracted(from other : Self) -> Self {
        return other.subtracted(by: self)
    }
    
    public mutating func subtract(from other : Self) {
        self = self.subtracted(from: other)
    }
    
    public mutating func multiply(scalar other : Component) {
        self = self.multiplying(scalar: other)
    }
    
    public mutating func divide(scalar other : Component) {
        self = self.dividing(scalar: other)
    }
    
    public mutating func multiply(by other : Self) {
        self = self.multiplied(by: other)
    }
    
    public mutating func divide(by other : Self) {
        self = self.divided(by: other)
    }
    
    public func divided(from other : Self) -> Self {
        return other.divided(by: self)
    }
    
    public mutating func divide(from other : Self) {
        self = self.divided(from: other)
    }
    
    mutating public func normalize() {
        self = self.normalized()
    }
}

