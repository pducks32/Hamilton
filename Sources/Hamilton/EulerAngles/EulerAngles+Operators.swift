//
//  EulerAngles+Operators.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 1/13/18.
//

import Foundation

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
