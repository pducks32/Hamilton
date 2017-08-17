//
//  Vectorable.swift
//  Pods
//
//  Created by Patrick Metcalfe on 10/20/16.
//
//

import Foundation

public protocol DegreesOfFreedom { }
public struct FourDegreesOfFreedom : DegreesOfFreedom {}
public struct ThreeDegreesOfFreedom : DegreesOfFreedom {}
public struct TwoDegreesOfFreedom : DegreesOfFreedom {}

public protocol Vectorable {
    associatedtype Size : DegreesOfFreedom
    associatedtype Component : Scalar
    
    var components : [Component] { get }
    
    var magnitude : Component { get }
    
    func dotting(_ other : Self) -> Component
    
    mutating func add(_ other : Self)
    func adding(_ other : Self) -> Self
    
    mutating func subtract(by other : Self)
    func subtracted(by other : Self) -> Self
    
    mutating func subtract(from other : Self)
    func subtracted(from other : Self) -> Self
    
    mutating func multiply(scalar other : Component)
    func multiplying(scalar other : Component) -> Self
    
    mutating func divide(scalar other : Component)
    func dividing(scalar other : Component) -> Self
    
    mutating func multiply(by other : Self)
    func multiplied(by other : Self) -> Self
    
    mutating func divide(by other : Self)
    func divided(by other : Self) -> Self
    
    mutating func divide(from other : Self)
    func divided(from other : Self) -> Self
    
    mutating func normalize()
    func normalized() -> Self
}

//extension RangeReplaceableCollection {
//    mutating func rotate(by shiftAmount : Int) {
//        self = self.rotated(by: shiftAmount)
//    }
//    
//    func rotated(by shiftAmount : Int) -> Self {
//        var alpha : Self = Self.init(self.dropFirst(shiftAmount))
//        var beta : Self = Self.init(prefix(shiftAmount))
//        return alpha.append(contentsOf: beta)
//    }
//}

extension Vectorable where Size == ThreeDegreesOfFreedom {
    public func crossing(with other : Self) -> Self {
        fatalError("Not Implemented")
    }
    
    public mutating func cross(with other : Self) {
        self = self.crossing(with: other)
    }
}

extension Vectorable where Component == Float {
    /// TODO: Square Root This Value
    public var magnitude : Float {
        let squaredValues : [Float] = components.map({ $0 * $0 })
        let squaredMagnitude = squaredValues.reduce(Float(0), { $0 + $1 })
        return sqrt(squaredMagnitude)
    }
}

extension Vectorable where Component == Double {
    /// TODO: Square Root This Value
    public var magnitude : Double {
        let squaredMagnitude = components.map({ $0 * $0 }).reduce(Double(0), { $0 + $1 })
        return sqrt(squaredMagnitude)
    }
}

extension Vectorable {
    
    public mutating func add(_ other : Self) {
        self = self.adding(other)
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
