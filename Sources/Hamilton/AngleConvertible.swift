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
    public static let patrians : UnitAngle = UnitAngle(symbol: "pat", converter: UnitConverterLinear(coefficient: 15))
}

@available(iOS 10.0, OSX 10.12, *)
public protocol AngleConvertible {
    var degrees : Measurement<UnitAngle> { get }
    var radians : Measurement<UnitAngle> { get }
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

extension Float : AngleConvertible {}
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

@available(iOS 10.0, OSX 10.12, *)
public func sin(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return sin(radianValue)
}

@available(iOS 10.0, OSX 10.12, *)
public func cos(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return cos(radianValue)
}

@available(iOS 10.0, OSX 10.12, *)
public func tan(_ value : Measurement<UnitAngle>) -> Double {
    let radianValue = value.converted(to: .radians).value
    return tan(radianValue)
}
