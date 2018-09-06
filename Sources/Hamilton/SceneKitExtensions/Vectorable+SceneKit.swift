//
//  Vectorable+SceneKit.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 8/28/18.
//

import Foundation

#if canImport(SceneKit)
import SceneKit

#if os(macOS)
public typealias SCNComponent = CGFloat
#else
public typealias SCNComponent = Float
#endif

extension Vector3 {
    public init(scnVector: SCNVector3) {
        self = Vector3(x: Component(scnVector.x), y: Component(scnVector.y), z: Component(scnVector.z))
    }
    
    public var asSceneVector : SCNVector3 {
        return SCNVector3(x: SCNComponent(x), y: SCNComponent(y), z: SCNComponent(z))
    }
}

extension Quaternion {
    public init(scnQuaternion: SCNQuaternion) {
        self = Quaternion(w: Component(scnQuaternion.w), x: Component(scnQuaternion.x), y: Component(scnQuaternion.y), z: Component(scnQuaternion.z))
    }
    
    public var asSceneQuaternion : SCNQuaternion {
        return SCNQuaternion(x: SCNComponent(x), y: SCNComponent(y), z: SCNComponent(z), w: SCNComponent(w))
    }
}

#endif
