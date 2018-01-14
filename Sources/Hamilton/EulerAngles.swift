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
    
    private func convertedSystemToXYZ() -> EulerAngles {
        switch system {
        case .xyz:
            return self
        case .xzy:
            return EulerAngles(pitch: self.pitch, yaw: self.roll, roll: self.yaw, system: .xyz)
        case .yxz:
            return  EulerAngles(pitch: self.yaw, yaw: self.pitch, roll: self.roll, system: .xyz)
        case .yzx:
            return EulerAngles(pitch: self.roll, yaw: self.pitch, roll: self.yaw, system: .xyz)
        case .zxy:
            return EulerAngles(pitch: self.yaw, yaw: self.roll, roll: self.pitch, system: .xyz)
        case .zyx:
            return  EulerAngles(pitch: self.roll, yaw: self.yaw, roll: self.pitch, system: .xyz)
        }
    }
    
    private func convertedSystemFromXYZ(to newSystem : System) -> EulerAngles {
        guard self.system == .xyz else {
            fatalError("private func convertedSystemFromXYZ called on object without an xyz system.")
        }
        
        switch newSystem {
        case .xyz:
            return self
        case .xzy:
            return EulerAngles(pitch: self.pitch, yaw: self.yaw, roll: self.roll, system: newSystem)
        case .yxz:
            return  EulerAngles(pitch: self.yaw, yaw: self.pitch, roll: self.roll, system: newSystem)
        case .yzx:
            return EulerAngles(pitch: self.yaw, yaw: self.roll, roll: self.pitch, system: newSystem)
        case .zxy:
            return EulerAngles(pitch: self.roll, yaw: self.pitch, roll: self.yaw, system: newSystem)
        case .zyx:
            return  EulerAngles(pitch: self.roll, yaw: self.yaw, roll: self.pitch, system: newSystem)
        }
    }
    
    public func convertedSystem(to newSystem : System) -> EulerAngles {
        if system == newSystem { return self }
        return convertedSystemToXYZ().convertedSystemFromXYZ(to: newSystem)
    }
    
    mutating public func convertSystem(to newSystem : System) {
        self = convertedSystem(to: newSystem)
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

@available(iOS 10.0, OSX 10.12, *)
extension EulerAngles : Equatable {
    public static func ==(lhs: EulerAngles, rhs: EulerAngles) -> Bool {
        if lhs.system == rhs.system {
            print("Called \(lhs.componentwiseDifferenceTo(rhs).magnitude)")
            return lhs.componentwiseDifferenceTo(rhs).magnitude < 0.5.degrees
        }
        return Quaternion(eulerAngles: lhs) == Quaternion(eulerAngles: rhs)
    }
    
    fileprivate var magnitude : Measurement<UnitAngle> {
        let zero = Measurement<UnitAngle>(value: 0, unit: self.pitch.unit)
        let addedSquareComponents = [self.pitch, self.yaw, self.roll].map { component -> Measurement<UnitAngle> in
            let squaredValue = pow(self.pitch.value, 2)
            return Measurement<UnitAngle>(value: squaredValue, unit: self.pitch.unit)
        }.reduce(zero, +)
        return Measurement<UnitAngle>(value: sqrt(addedSquareComponents.value), unit: addedSquareComponents.unit)
    }
    
    public func componentwiseDifferenceTo(_ otherEulerAngles : EulerAngles) -> EulerAngles {
        let pitchChange = otherEulerAngles.pitch - self.pitch
        let yawChange = otherEulerAngles.yaw - self.yaw
        let rollChange = otherEulerAngles.roll - self.roll
        return EulerAngles(pitch: pitchChange, yaw: yawChange, roll: rollChange)
    }
}
