//
//  Test.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/13.
//

import Testing
import SwiftUI

@testable import GeometryKit


struct VectorTests {

    // test vector operations
    @Test func testVectorOperations() async throws {
        
        let u = CGPoint(1, 2)
        let a = CGFloat(-2)
        
        // scalar multiplication
        #expect(a * u == CGPoint(-2, -4))
        #expect((u / a).isAlmostEqual(to: CGPoint(-0.5, -1)) )
    }
    
    // test vector instance methods
    @Test func testInstanceMethods() async throws {
        
        let u = CGPoint(1, 2)
        let v = CGPoint(3, 4)
        let t = CGFloat(-2)
        
        // linear interpolation
        #expect(u.lerp(to: v, t: t).isAlmostEqual(to: CGPoint(-3, -2)))
    }

}
