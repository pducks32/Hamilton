//
//  VectorableFormatter.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 1/4/18.
//

import Foundation

public class VectorableFormatter {
    public enum JoinStyle {
        case components, tuple(surroundedBy : String)
    }
    
    public var joinStyle : JoinStyle
    
    public init(joinStyle : JoinStyle = .tuple(surroundedBy: "()")) {
        self.joinStyle = joinStyle
    }
    
    public func string<V : Vectorable>(from vector : V) -> String {
        switch joinStyle {
        case .components:
            return zip(vector.components, ["i", "j", "k"]).map({ "\($0)\($1)" }).joined(separator: "+")
        case .tuple(let surroundedBy):
            let parts = surroundedBy.split(separator: Character(""))
            vector.components.map(String.init(describing:)).joined(separator: ", ")
        }
        
        vector.components
    }
}
