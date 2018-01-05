//
//  VectorableFormatter.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 1/4/18.
//

import Foundation

extension String {
    func character(at offset : Int) -> Character? {
        if offset > self.count {
            return nil
        }
        return self[index(startIndex, offsetBy: offset)]
    }
}

public class VectorableFormatter {
    public enum JoinStyle {
        case components, tuple(surroundedBy : String)
    }
    
    public static var defaultNumberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    public var joinStyle : JoinStyle
    public var numberFormatter : NumberFormatter
    
    public init(joinStyle : JoinStyle = .tuple(surroundedBy: "()"), numberFormatter : NumberFormatter? = nil) {
        self.joinStyle = joinStyle
        self.numberFormatter = numberFormatter ?? VectorableFormatter.defaultNumberFormatter
    }
    
    public func string<V : Vectorable>(from vector : V) -> String {
        return formatVector(vector)
    }
    
    public func string(from vector : Vector4) -> String {
        return formatVector(vector, using: ["w", "i", "j", "k"])
    }
    
    public func string(from quat : Quaternion) -> String {
        return formatVector(quat, using: ["w", "i", "j", "k"])
    }
    
    private func formatVector<V : Vectorable>(_ vector : V, using : [String] = ["i", "j", "k"]) -> String {
        switch joinStyle {
        case .components:
            return zip(vector.components, using).map({ "\(self.toFormattedNumber($0.doubleValue))\($1)" }).joined(separator: "+")
        case .tuple(let surroundedBy):
            let (opening, ending) = breakDownSurroundBy(surroundedBy)
            let middle = vector.components.map({ component in
                self.toFormattedNumber(component.doubleValue)
            }).joined(separator: ", ")
            return opening + middle + ending
        }
    }
    
    private func toFormattedNumber(_ component : Double) -> String {
        let number = NSNumber(value: component)
        return self.numberFormatter.string(from: number)!
    }
    
    private func breakDownSurroundBy(_ surroundedBy : String) -> (String, String) {
        let firstLetter : String
        if let firstChar = surroundedBy.character(at: 0) {
            firstLetter = "\(firstChar)"
        } else {
            firstLetter = ""
        }
        
        let secondLetter : String
        if let secondChar = surroundedBy.character(at: 1) {
            secondLetter = "\(secondChar)"
        } else {
            secondLetter = ""
        }
        
        
        return (firstLetter, secondLetter)
    }
}
