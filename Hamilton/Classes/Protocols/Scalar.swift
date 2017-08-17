//
//  Scalar.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 6/15/17.
//

import Foundation

public protocol Scalar : FloatingPoint {
    var doubleValue : Double { get }
    var floatValue : Float { get }
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
