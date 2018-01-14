//
//  Scalar.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

/// Represents a scalar value in Hamilton
/// Really a way to get around Swift's bad Numeric's system
public protocol Scalar {
    /// `self` as a `Double`
    var doubleValue : Double { get }
    
    /// `self` as a `Float`
    var floatValue : Float { get }
    
    static func *(_ lhs : Self, _ rhs : Self) -> Self
    static func -(_ lhs : Self, _ rhs : Self) -> Self
    static func +(_ lhs : Self, _ rhs : Self) -> Self
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
