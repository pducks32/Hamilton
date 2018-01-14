# Hamilton

[![CI Status](http://img.shields.io/travis/pducks32/Hamilton.svg?style=flat)](https://travis-ci.org/pducks32/Hamilton)
[![Version](https://img.shields.io/cocoapods/v/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)
[![License](https://img.shields.io/cocoapods/l/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)
[![Platform](https://img.shields.io/cocoapods/p/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)

## Requirements

Using Swift 4. Please be aware.

## Basic Usage
* Only Right handed coordinate systems are currently supported. Please be aware as Unity, Unreal, and DirectX use left handed systems.

### Basic Operations
```swift
let baseVector = Vector3(1, 6, 5)
let otherVector = Vector3(7, 1, 3)

baseVector.adding(otherVector) //=> Vector3(8, 7, 8)
baseVector.magnitude //=> 7.874
```

### Rotations
```swift
let baseVector = Vector3(0, 1, 0)

let quat = Quaternion(axis: .xAxis, angle: Degrees(90))
let eulerAngles = EulerAngles(pitch: 90.degrees, yaw: 0.degrees, roll: 0.degrees, system: .xyz)

baseVector.rotated(by: quat) //=> Vector3(0, 0, 1)
baseVector.rotated(by: eulerAngles) // -> Vector3(0, 0, 1)
```

## Installation

Hamilton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Hamilton"
```

## Author

Patrick Metcalfe, git@patrickmetcalfe.com

## License

Hamilton is available under the MIT license. See the LICENSE file for more info.
