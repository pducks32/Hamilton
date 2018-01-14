//
//  AngleConvertible.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation


/// UnitAngle.radians.coefficient is a truncated version of 180.0 / Double.pi
/// this fixes it until Apple resolves the issue in Objective-C Foundation
@available(iOS 10.0, OSX 10.12, *)
public func FixUnitAngleConversion() {
    guard let converter = UnitAngle.radians.converter as? UnitConverterLinear else { return }
    converter.setValue(180.0 / Double.pi, forKey: "coefficient")
}

@available(iOS 10.0, OSX 10.12, *)
extension UnitAngle {
    /// Patrians represent 15deg increments. So 1pat=15deg, 2pat=30deg, etc
    public static let patrians : UnitAngle = UnitAngle(symbol: "pat", converter: UnitConverterLinear(coefficient: 15))
}

@available(iOS 10.0, OSX 10.12, *)
public protocol AngleConvertible {
    /// Returns self as a degree measurement
    var degrees : Measurement<UnitAngle> { get }
    /// Returns self as a radians measurement
    var radians : Measurement<UnitAngle> { get }
    /// Returns self as a patrian measurement
    var patrians : Measurement<UnitAngle> { get }
}

@available(iOS 10.0, OSX 10.12, *)
extension AngleConvertible where Self : Scalar {
    public var degrees : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: doubleValue, unit: .degrees)
    }
    
    public var radians : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: doubleValue, unit: .radians)
    }
    
    public var patrians : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: doubleValue, unit: .patrians)
    }
}

@available(iOS 10.0, OSX 10.12, *)
extension Float : AngleConvertible {}
@available(iOS 10.0, OSX 10.12, *)
extension Double : AngleConvertible {}

@available(iOS 10.0, OSX 10.12, *)
extension Int : AngleConvertible {
    public var degrees : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: Double(self), unit: .degrees)
    }
    
    public var radians : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: Double(self), unit: .radians)
    }
    
    public var patrians : Measurement<UnitAngle> {
        return Measurement<UnitAngle>(value: Double(self), unit: .patrians)
    }
}

/// Takes sin of measurement's radian value
@available(iOS 10.0, OSX 10.12, *)
public func sin(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return sin(radianValue)
}

/// Takes cos of measurement's radian value
@available(iOS 10.0, OSX 10.12, *)
public func cos(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return cos(radianValue)
}

/// Takes tan of measurement's radian value
@available(iOS 10.0, OSX 10.12, *)
public func tan(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return tan(radianValue)
}
