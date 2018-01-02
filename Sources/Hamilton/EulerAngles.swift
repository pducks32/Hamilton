//
//  EulerAngles.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation
import simd

@available(iOS 10.0, OSX 10.12, *)
public func Radians(_ value : Double) -> Measurement<UnitAngle> {
    return Measurement<UnitAngle>(value: value, unit: .radians)
}

@available(iOS 10.0, OSX 10.12, *)
public func Degrees(_ value : Double) -> Measurement<UnitAngle> {
    return Measurement<UnitAngle>(value: value, unit: .degrees)
}

@available(iOS 10.0, OSX 10.12, *)
public struct EulerAngles {
    public enum System : String {
        case xyz, yxz, zxy, zyx, yzx, xzy
    }
    
    public var pitch : Measurement<UnitAngle>
    public var yaw : Measurement<UnitAngle>
    public var roll : Measurement<UnitAngle>
    public var system : System
    
    public init(pitch : Measurement<UnitAngle>, yaw : Measurement<UnitAngle>, roll : Measurement<UnitAngle>, system : System = .xyz) {
        self.pitch = pitch
        self.yaw = yaw
        self.roll = roll
        self.system = system
    }
    
    public init(vector3 : vector_float3, unit : UnitAngle) {
        self.pitch = Measurement<UnitAngle>(value: Double(vector3.x), unit: unit)
        self.yaw = Measurement<UnitAngle>(value: Double(vector3.y), unit: unit)
        self.roll = Measurement<UnitAngle>(value: Double(vector3.z), unit: unit)
        self.system = .xyz
    }
    
    public mutating func convert(to newUnit : UnitAngle) {
        self = converted(to: newUnit)
    }
    
    public func converted(to newUnit : UnitAngle) -> EulerAngles {
        var result = self
        result.pitch.convert(to: newUnit)
        result.yaw.convert(to: newUnit)
        result.roll.convert(to: newUnit)
        return result
    }
}

@available(iOS 10.0, OSX 10.12, *)
public func +(_ rhs : Measurement<UnitAngle>, _ lhs : Measurement<UnitAngle>) -> Measurement<UnitAngle> {
    if rhs.unit == lhs.unit {
        return Measurement<UnitAngle>(value: rhs.value + lhs.value, unit: rhs.unit)
    } else {
        return Measurement<UnitAngle>(value: rhs.value + lhs.converted(to: rhs.unit).value, unit: rhs.unit)
    }
}

@available(iOS 10.0, OSX 10.12, *)
public func -(_ rhs : Measurement<UnitAngle>, _ lhs : Measurement<UnitAngle>) -> Measurement<UnitAngle> {
    if rhs.unit == lhs.unit {
        return Measurement<UnitAngle>(value: rhs.value - lhs.value, unit: rhs.unit)
    } else {
        return Measurement<UnitAngle>(value: rhs.value - lhs.converted(to: rhs.unit).value, unit: rhs.unit)
    }
}

@available(iOS 10.0, OSX 10.12, *)
public func -=(_ rhs : inout Measurement<UnitAngle>, _ lhs : Measurement<UnitAngle>) {
    rhs = rhs - lhs
}

@available(iOS 10.0, OSX 10.12, *)
public func +=(_ rhs : inout Measurement<UnitAngle>, _ lhs : Measurement<UnitAngle>) {
    rhs = rhs + lhs
}
