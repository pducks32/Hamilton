//
//  EulerAngles.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation
import simd

/// Encapsulates a pitch/yaw/roll rotation
///
/// Pitch, yaw, roll are soley meant to represent
/// the order the rotation should happen in and not
/// in whichever mental system one predisposes themself
/// towards.
///
/// - SeeAlso: EulerAngles.System
@available(iOS 10.0, OSX 10.12, *)
public struct EulerAngles {
    
    /// Describes a order of applying rotations
    ///
    /// Euler angles are a collection of 3 axis-angle
    /// rotations which can be applied in different orders.
    /// These orders are often confused so it's made
    /// explicit in this library.
    ///
    /// They precede on the axis listed in the name from
    /// left to right. So `xyz` is X then Y then Z and the
    /// angle that is used is pitch then yaw then roll.
    /// For `zxy` is Z, X, Y and the angles are *still*
    /// pitch then yaw then roll
    ///
    /// - Warning: All currently supported systems are absolute
    /// meaning they are applied to an airplane from outside
    /// and not from inside the cockpit.
    public enum System : String {
        case xyz, yxz, zxy, zyx, yzx, xzy
    }
    
    /// The angle used on the first axis rotation
    public var pitch : Measurement<UnitAngle>
    /// The angle used on the second axis rotation
    public var yaw : Measurement<UnitAngle>
    /// The angle used on the third axis rotation
    public var roll : Measurement<UnitAngle>
    /// The system describing the axis orders to apply rotations
    public var system : System
    
    /// Create new EulerAngles with given angles and system (default: `.xyz`)
    public init(pitch : Measurement<UnitAngle>, yaw : Measurement<UnitAngle>, roll : Measurement<UnitAngle>, system : System = .xyz) {
        self.pitch = pitch
        self.yaw = yaw
        self.roll = roll
        self.system = system
    }
    
    /// Create EulerAngles with given vector of angles and unit and system (default: `.xyz`)
    public init(vectorOfAngles : vector_float3, unit : UnitAngle, system : System = .xyz) {
        self.pitch = Measurement<UnitAngle>(value: Double(vectorOfAngles.x), unit: unit)
        self.yaw = Measurement<UnitAngle>(value: Double(vectorOfAngles.y), unit: unit)
        self.roll = Measurement<UnitAngle>(value: Double(vectorOfAngles.z), unit: unit)
        self.system = system
    }
    
    /// Create EulerAngles with given vector of angles and unit and system (default: `.xyz`)
    public init(vectorOfAngles : Vector3, unit : UnitAngle, system : System = .xyz) {
        self.pitch = Measurement<UnitAngle>(value: Double(vectorOfAngles.x), unit: unit)
        self.yaw = Measurement<UnitAngle>(value: Double(vectorOfAngles.y), unit: unit)
        self.roll = Measurement<UnitAngle>(value: Double(vectorOfAngles.z), unit: unit)
        self.system = system
    }
    
    /// Converts measurement values to `newUnit`
    public mutating func convert(to newUnit : UnitAngle) {
        self = converted(to: newUnit)
    }
    
    /// Converts measurement values to `newUnit` into a new `EulerAngles`
    public func converted(to newUnit : UnitAngle) -> EulerAngles {
        var result = self
        result.pitch.convert(to: newUnit)
        result.yaw.convert(to: newUnit)
        result.roll.convert(to: newUnit)
        return result
    }
    
    /// Reorders angles into order described by `newSystem`
    mutating public func convertSystem(to newSystem : System) {
        self = convertedSystem(to: newSystem)
    }
    
    /// Reorders angles into order described by `newSystem` into new `EulerAngles`
    public func convertedSystem(to newSystem : System) -> EulerAngles {
        if system == newSystem { return self }
        return convertedSystemToXYZ().convertedSystemFromXYZ(to: newSystem)
    }
    
    // MARK: Conversion Helpers
    
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
}
