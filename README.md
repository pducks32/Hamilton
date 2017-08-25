# Hamilton

[![CI Status](http://img.shields.io/travis/pducks32/Hamilton.svg?style=flat)](https://travis-ci.org/pducks32/Hamilton)
[![Version](https://img.shields.io/cocoapods/v/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)
[![License](https://img.shields.io/cocoapods/l/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)
[![Platform](https://img.shields.io/cocoapods/p/Hamilton.svg?style=flat)](http://cocoapods.org/pods/Hamilton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Using Swift 4. Please be aware.

## Usage

```swift
let quat = Quaternion(axis: .xAxis, angle: Degrees(90))
let rotatedQuat = Vector3(0, 1, 0).rotating(by quat) //=> Vector3(0, 0, 1)
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
