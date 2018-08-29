//
//  Vectorable+SceneKit.swift
//  Hamilton
//
//  Created by Patrick Metcalfe on 8/28/18.
//

import Foundation

#if canImport(SceneKit)
import SceneKit

extension Vector3 {
    public init(scnVector: SCNVector3) {
        self = Vector3(x: Component(scnVector.x), y: Component(scnVector.y), z: Component(scnVector.z))
    }
    
    public var asSceneVector : SCNVector3 {
        return SCNVector3(x: Float(x), y: Float(y), z: Float(z))
    }
}

extension Quaternion {
    public init(scnQuaternion: SCNQuaternion) {
        self = Quaternion(w: Component(scnQuaternion.w), x: Component(scnQuaternion.x), y: Component(scnQuaternion.y), z: Component(scnQuaternion.z))
    }
    
    public var asSceneQuaternion : SCNQuaternion {
        return SCNQuaternion(x: Float(x), y: Float(y), z: Float(z), w: Float(w))
    }
}

#endif
