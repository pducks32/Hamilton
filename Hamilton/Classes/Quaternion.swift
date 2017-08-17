//
//  Quaternion.swift
//  Pods
//
//  Created by Patrick Metcalfe on 5/29/17.
//
//

import Foundation
import SceneKit

extension GLKMatrix4 : CustomDebugStringConvertible {
    public var debugDescription: String {
        let topRow = GLKMatrix4GetRow(self, 0)
        let secondRow = GLKMatrix4GetRow(self, 1)
        let thirdRow = GLKMatrix4GetRow(self, 2)
        let bottomRow = GLKMatrix4GetRow(self, 3)
        

        return ["\(topRow.v)", "\(secondRow.v)", "\(thirdRow.v)", "\(bottomRow.v)"].joined(separator: "\n")
    }
}

public struct Quaternion : Vectorable {
    public typealias Size = FourDegreesOfFreedom
    public typealias Component = Double
    
    public let w : Component
    public let x : Component
    public let y : Component
    public let z : Component
    
    public var components : [Component] {
        return [w, x, y, z]
    }
    
    public init(axis : Vector3, degrees : Double) {
        self.init(axis : axis, radians : degrees * Double.pi / 180)
    }
    
    @available(iOS 10.0, *)
    public init(axis: Vector3, angle : Measurement<UnitAngle>) {
        self.init(axis : axis, radians : angle.converted(to: .radians).value)
    }
    
    public init(axis : Vector3, radians : Double) {
        let halfAngle = radians / 2
        let s = sin(halfAngle);
        
        w = cos(halfAngle);
        let scaledAxis = axis.normalized()
        x = Component(scaledAxis.x) * s
        y = Component(scaledAxis.y) * s
        z = Component(scaledAxis.z) * s
    }
    
    public init(between vectorOne : Vector3, and vectorTwo : Vector3) {
        let perpendicular = vectorOne.crossing(with: vectorTwo)
        x = Quaternion.Component(perpendicular.x)
        y = Quaternion.Component(perpendicular.y)
        z = Quaternion.Component(perpendicular.z)
        let area = vectorOne.dotting(vectorTwo)
        let radiusBetweenMagnitudes = sqrt(pow(vectorOne.magnitude, 2) * pow(vectorTwo.magnitude, 2))
        w = Quaternion.Component(radiusBetweenMagnitudes) + Quaternion.Component(area)
        normalize()
    }
    
    @available(iOS 10.0, *)
    public init(eulerAngles : EulerAngles) {
        let c1 = cos(eulerAngles.pitch / 2)
        let c2 = cos(eulerAngles.yaw / 2)
        let c3 = cos(eulerAngles.roll / 2)
        
        let s1 = sin(eulerAngles.pitch / 2)
        let s2 = sin(eulerAngles.yaw / 2)
        let s3 = sin(eulerAngles.roll / 2)
        
        switch eulerAngles.system {
        case .xyz:
            x = s1 * c2 * c3 + c1 * s2 * s3;
            y = c1 * s2 * c3 - s1 * c2 * s3;
            z = c1 * c2 * s3 + s1 * s2 * c3;
            w = c1 * c2 * c3 - s1 * s2 * s3;
            break
        case .yxz:
            x = s1 * c2 * c3 + c1 * s2 * s3;
            y = c1 * s2 * c3 - s1 * c2 * s3;
            z = c1 * c2 * s3 - s1 * s2 * c3;
            w = c1 * c2 * c3 + s1 * s2 * s3;
            break
        case .zxy:
            x = s1 * c2 * c3 - c1 * s2 * s3;
            y = c1 * s2 * c3 + s1 * c2 * s3;
            z = c1 * c2 * s3 + s1 * s2 * c3;
            w = c1 * c2 * c3 - s1 * s2 * s3;
            break
        case .zyx:
            x = s1 * c2 * c3 - c1 * s2 * s3;
            y = c1 * s2 * c3 + s1 * c2 * s3;
            z = c1 * c2 * s3 - s1 * s2 * c3;
            w = c1 * c2 * c3 + s1 * s2 * s3;
            break
        case .yzx:
            x = s1 * c2 * c3 + c1 * s2 * s3;
            y = c1 * s2 * c3 + s1 * c2 * s3;
            z = c1 * c2 * s3 - s1 * s2 * c3;
            w = c1 * c2 * c3 - s1 * s2 * s3;
            break
        case .xzy:
            x = s1 * c2 * c3 - c1 * s2 * s3;
            y = c1 * s2 * c3 - s1 * c2 * s3;
            z = c1 * c2 * s3 + s1 * s2 * c3;
            w = c1 * c2 * c3 + s1 * s2 * s3;
        }
    }
    
    public init(w : Component, x : Component, y : Component, z : Component) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func dotting(_ other : Quaternion) -> Component {
        return sqrt((w * other.w) + (x * other.x) + (y * other.y) + (z * other.z))
    }
    
    public func crossing(_ other : Quaternion) -> Quaternion {
        let neww = w * other.w
        let newx = x * other.x
        let newy = y * other.y
        let newz = z * other.z
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func adding(_ other : Quaternion) -> Quaternion {
        let neww = w + other.w
        let newx = x + other.x
        let newy = y + other.y
        let newz = z + other.z
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func subtracted(by other : Quaternion) -> Quaternion {
        let neww = w - other.w
        let newx = x - other.x
        let newy = y - other.y
        let newz = z - other.z
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func multiplying(scalar other : Component) -> Quaternion {
        let neww = w * other
        let newx = x * other
        let newy = y * other
        let newz = z * other
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func dividing(scalar other : Component) -> Quaternion {
        return multiplying(scalar: 1 / other)
    }
    
    /// Returns composition of `self` and then `other`.
    public func multiplied(by other : Quaternion) -> Quaternion {
        let newx = x * other.w + w * other.x + y * other.z - z * other.y;
        let newy = y * other.w + w * other.y + z * other.x - x * other.z;
        let newz = z * other.w + w * other.z + x * other.y - y * other.x;
        let neww = w * other.w - x * other.x - y * other.y - z * other.z;
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    /// Returns composition of `other` and then `self`
    public func premultiplied(by other : Quaternion) -> Quaternion {
        return other.multiplied(by: self)
    }
    
    public var conjugated : Quaternion {
        return Quaternion(w: w, x: -x, y: -y, z: -z)
    }
    
    public var inverse : Quaternion {
        return conjugated.normalized()
    }
    
    public func divided(by other : Quaternion) -> Quaternion {
        let neww = w / other.w
        let newx = x / other.x
        let newy = y / other.y
        let newz = z / other.z
        return Quaternion(w: neww, x: newx, y: newy, z: newz)
    }
    
    public func normalized() -> Quaternion {
        return self.multiplying(scalar: 1 / magnitude)
    }
    
    @available(iOS 10.0, *)
    public var asAxisAngle : (axis: Vector3, angle : Measurement<UnitAngle>) {
        let q = w > 1 ? self : self.normalized()
        let angle = 2 * acos(q.w);
        let s = sqrt(1.0 - q.w*q.w); // assuming quaternion normalised then w is less than 1, so term always positive.
        var x : Double = 0, y : Double = 0, z : Double = 0
        if (s < 0.001) { // test to avoid divide by zero, s is always positive due to sqrt
            // if s close to zero then direction of axis not important
            x = q.x; // if it is important that axis is normalised then replace with x=1; y=z=0;
            y = q.y;
            z = q.z;
        } else {
            x = q.x / s; // normalise axis
            y = q.y / s;
            z = q.z / s;
        }
        let v = Vector3(x: Float(x), y: Float(y), z: Float(z))
        return (v, angle.radians)
    }
    
    public var asMatrix : GLKMatrix4 {
        var matrix = GLKMatrix4()
        let x2 = x + x
        let y2 = y + y
        let z2 = z + z
        
        let xx = x * x2, xy = x * y2, xz = x * z2
        let yy = y * y2, yz = y * z2, zz = z * z2
        let wx = w * x2, wy = w * y2, wz = w * z2
        matrix.m00 = Float(1.0 - (yy + zz))
        matrix.m10 = Float(xy - wz)
        matrix.m20 = Float(xz + wy)
        
        matrix.m01 = Float(xy + wz)
        matrix.m11 = Float(1.0 - (xx + zz))
        matrix.m21 = Float(yz - wx)
        
        matrix.m02 = Float(xz - wy)
        matrix.m12 = Float(yz + wx)
        matrix.m22 = Float(1.0 - ( xx + yy ))
        
        // Last Column
        matrix.m03 = 0
        matrix.m13 = 0
        matrix.m23 = 0
        
        // Bottom Row
        matrix.m30 = 0
        matrix.m31 = 0
        matrix.m32 = 0
        matrix.m33 = 1
        return matrix
    }
}

extension Quaternion : Equatable {}
public func ==(_ rhs : Quaternion, _ lhs : Quaternion) -> Bool {
    return rhs.w == lhs.w && rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
}
