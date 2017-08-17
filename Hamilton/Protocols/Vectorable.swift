//
//  Vectorable.swift
//  Pods
//
//  Created by Patrick Metcalfe on 10/20/16.
//
//

import Foundation

public protocol Scalar {
    var doubleValue : Double { get }
    var floatValue : Float { get }
    
    mutating func add(_ other : Self)
    func adding(_ other : Self) -> Self
    
    mutating func subtract(_ other : Self)
    func subtracting(_ other : Self) -> Self
    
    mutating func multiply(by other : Self)
    func multiplied(by other : Self) -> Self
    
    mutating func divide(by other : Self)
    func divided(by other : Self) -> Self
    
    mutating func divide(from other : Self)
    func divided(from other : Self) -> Self
}

extension Scalar {
    mutating public func subtract(_ other: Self) {
        self = subtracting(other)
    }
    
    mutating public func add(_ other: Self) {
        self = adding(other)
    }
    
    mutating public func divide(by other : Self) {
        self = divided(by: other)
    }
    
    public func divided(from other : Self) -> Self {
        return other.divided(by: other)
    }
    
    mutating public func divide(from other : Self) {
        self = divided(from: other)
    }
    
    mutating public func multiply(by other: Self) {
        self = multiplied(by: other)
    }
}

extension Double : Scalar {
    public var doubleValue: Double {
        return self
    }
    
    public var floatValue: Float {
        return Float(self)
    }
}

extension Float : Scalar {
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var floatValue: Float {
        return self
    }
}
extension Int : Scalar {
    public var doubleValue: Double {
        return Double(self)
    }
    
    public var floatValue: Float {
        return Float(self)
    }
    
    public func divided(by other: Int) -> Int {
        return self / other
    }

    public func multiplied(by other: Int) -> Int {
        return self * other
    }

    public func subtracting(_ other: Int) -> Int {
        return self - other
    }

    public func adding(_ other: Int) -> Int {
        return self + other
    }
}
public protocol DegreesOfFreedom { }
public struct FourDegreesOfFreedom : DegreesOfFreedom {}
public struct ThreeDegreesOfFreedom : DegreesOfFreedom {}
public struct TwoDegreesOfFreedom : DegreesOfFreedom {}

public protocol Vectorable {
    associatedtype Size : DegreesOfFreedom
    associatedtype Component
    
    var components : [Component] { get }
    
    var magnitude : Component { get }
    
    func dotting(_ other : Self) -> Component
    
    mutating func cross(_ other : Self)
    func crossing(_ other : Self) -> Self
    
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
extension Vectorable where Component == Int {
    /// TODO: This is really bad
    var magnitude : Int {
        let squaredMagnitude : Int = components.map({ $0 * $0 }).reduce(0, { $0 + $1 })
        return Int(sqrt(Double(squaredMagnitude)))
    }
}

extension Vectorable {
    
    public mutating func cross(_ other : Self) {
        self = self.crossing(other)
    }
    
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

public struct Vector2 : Vectorable {

    public typealias Size = TwoDegreesOfFreedom
    public typealias Component = Float
    
    public let x : Component
    public let y : Component
    
    public var components : [Component] {
        return [x, y]
    }
    
    public init(x : Component, y : Component) {
        self.x = x
        self.y = y
    }
    
    public func dotting(_ other : Vector2) -> Component {
        return sqrt((x * other.x) + (y * other.y))
    }
    
    public func crossing(_ other : Vector2) -> Vector2 {
        let newx = x * other.x
        let newy = y * other.y
        return Vector2(x: newx, y: newy)
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

public struct Vector3 : Vectorable {
    
    public static let xAxis = Vector3(1, 0, 0)
    public static let yAxis = Vector3(1, 0, 0)
    public static let zAxis = Vector3(1, 0, 0)

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
        return sqrt((x * other.x) + (y * other.y) + (z * other.z))
    }
    
    public func crossing(_ other : Vector3) -> Vector3 {
        let newx = x * other.x
        let newy = y * other.y
        let newz = z * other.z
        return Vector3(x: newx, y: newy, z: newz)
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
}
public struct Vector4 : Vectorable {
    public typealias Size = FourDegreesOfFreedom
    public typealias Component = Float
    
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
    
    public func crossing(_ other : Vector4) -> Vector4 {
        let neww = w * other.w
        let newx = x * other.x
        let newy = y * other.y
        let newz = z * other.z
        return Vector4(w: neww, x: newx, y: newy, z: newz)
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
