//
//  MatrixTests.swift
//  HamiltonTests
//
//  Created by Patrick Metcalfe on 6/26/18.
//

import XCTest
@testable import Hamilton

class MatrixTests: XCTestCase {
    
    func testTwoTypesOfMatricesMatch() {
        let quaternion = Quaternion(between: Vector3(1.2, 0.8, 0.5), and: Vector3(0.13, 0.41, 1.3)).normalized()
        let simdMatrix = quaternion.asSimdMatrix
        let glkMatrix = quaternion.asMatrix
        
        let simdValue : ((Int, Int) -> Float) = { a, b in
            return Float(simdMatrix[a][b])
        }
        
        XCTAssertEqual(simdValue(0, 0), glkMatrix.m00)
        XCTAssertEqual(simdValue(0, 1), glkMatrix.m10)
        XCTAssertEqual(simdValue(0, 2), glkMatrix.m20)
        XCTAssertEqual(simdValue(0, 3), glkMatrix.m30)
        
        XCTAssertEqual(simdValue(1, 0), glkMatrix.m01)
        XCTAssertEqual(simdValue(1, 1), glkMatrix.m11)
        XCTAssertEqual(simdValue(1, 2), glkMatrix.m21)
        XCTAssertEqual(simdValue(1, 3), glkMatrix.m31)
        
        XCTAssertEqual(simdValue(2, 0), glkMatrix.m02)
        XCTAssertEqual(simdValue(2, 1), glkMatrix.m12)
        XCTAssertEqual(simdValue(2, 2), glkMatrix.m22)
        XCTAssertEqual(simdValue(2, 3), glkMatrix.m32)
        
        XCTAssertEqual(simdValue(3, 0), glkMatrix.m03)
        XCTAssertEqual(simdValue(3, 1), glkMatrix.m13)
        XCTAssertEqual(simdValue(3, 2), glkMatrix.m23)
        XCTAssertEqual(simdValue(3, 3), glkMatrix.m33)
    }

}
