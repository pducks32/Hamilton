//
//  EulerAngles+Equatable.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 1/13/18.
//

import Foundation

@available(iOS 10.0, OSX 10.12, *)
extension EulerAngles : Equatable {
    public static func ==(lhs: EulerAngles, rhs: EulerAngles) -> Bool {
        return lhs.isEqual(rhs)
    }
    
    /// Tests if two `EulerAngles` are within a given magnitude of eachother.
    /// - Note: Converts their systems to match
    public func isEqual(_ otherEulerAngles : EulerAngles, within : Measurement<UnitAngle> = 0.5.degrees) -> Bool {
        return self.rootMeanSquareComponentDifferenceTo(otherEulerAngles) < within
    }
    
    /// Returns euclidean distance between 2 `EulerAngles` by their components.
    /// - Note: Converts their systems to match
    public func rootMeanSquareComponentDifferenceTo(_ otherEulerAngles : EulerAngles) -> Measurement<UnitAngle> {
        return componentwiseDifferenceTo(otherEulerAngles).magnitude
    }
    
    /// Subtracts two euler angles by their components
    /// - Note: Converts their systems into eachother
    public func componentwiseDifferenceTo(_ otherEulerAngles : EulerAngles) -> EulerAngles {
        let other = otherEulerAngles.convertedSystem(to: self.system)
        let pitchChange = other.pitch - self.pitch
        let yawChange = other.yaw - self.yaw
        let rollChange = other.roll - self.roll
        return EulerAngles(pitch: pitchChange, yaw: yawChange, roll: rollChange, system: system)
    }
    
    /// Takes euclidean distance of an euler angle by components.
    fileprivate var magnitude : Measurement<UnitAngle> {
        let zero = Measurement<UnitAngle>(value: 0, unit: self.pitch.unit)
        let addedSquareComponents = [self.pitch, self.yaw, self.roll].map { component -> Measurement<UnitAngle> in
            let squaredValue = pow(self.pitch.value, 2)
            return Measurement<UnitAngle>(value: squaredValue, unit: self.pitch.unit)
        }.reduce(zero, +)
        return Measurement<UnitAngle>(value: sqrt(addedSquareComponents.value), unit: addedSquareComponents.unit)
    }
}
