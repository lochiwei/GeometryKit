//
//  Test.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/11.
//
// ---------------------------------------------------------

// 1️⃣ 匯入 Swift Testing 模組  5️⃣
import Testing              // ⭐️ import `Testing` (Swift Playgrounds 上不適用)

// 2️⃣ 匯入要測試的模組
@testable                   // ⭐️ @testable：要測試的模組前要加這個
import GeometryKit

// ---------------------------------------------------------

import CoreGraphics


// -------------------------------------------

// 1️⃣ Swift Testing 模組
// ⭐️ Swift Playgrounds 上不適用
import Testing


// 2️⃣ 匯入要測試的模組
@testable               // ⭐️ @testable
import GeometryKit

// -------------------------------------------

import CoreGraphics


// 3️⃣ 透過 struct 包裝要測試的東西（比較不會產生名稱衝突）
struct Vector2DTests {
    
    // ① Arragne
    
    // vectors
    let u = CGPoint(1, 2)
    let v = CGPoint(3, 4)
    
    
    // scalars
    let a: CGFloat = -3

    // 4️⃣ 寫要測試的東西（透過 instance method）
    @Test
    func testOperations() async throws {
        
        // variable (for compound assignment)
        var w = CGPoint(-2, 1)
        
        // -v: additive inverse
        #expect((-v).isAlmostEqual(to: CGPoint(-3, -4)))
        
        // u + v: addition
        #expect((u + v).isAlmostEqual(to: CGPoint(4,6)))
        
        // u - v: subtraction
        #expect((u - v).isAlmostEqual(to: CGPoint(-2, -2)))
        
        // v * a = a * v: scalar multiplication
        #expect((v * a).isAlmostEqual(to: CGPoint(-9, -12)))
        #expect((a * v).isAlmostEqual(to: CGPoint(-9, -12)))
        
        // v / a: scaler multiplication
        #expect((v / a).isAlmostEqual(to: CGPoint(-1, -4/3)))
        
        // dot
        #expect(u.dot(v) == 11)
        
        // cross
        #expect(u.cross(v) == -2)
        
        // compound assignments
        
        // +=
        w += v
        #expect(w.isAlmostEqual(to: CGPoint(1, 5)))
        
        // -=
        w -= u
        #expect(w.isAlmostEqual(to: CGPoint(0, 3)))
        
        // *=
        w *= a
        #expect(w.isAlmostEqual(to: CGPoint(0, -9)))
        
        // /=
        w /= 2
        #expect(w.isAlmostEqual(to: CGPoint(0, -9/2)))
    }
    
    // test constants
    @Test func testConstants() async throws {
        #expect(CGPoint.zero == CGPoint(0, 0))
        #expect(CGPoint.i == CGPoint(1, 0))
        #expect(CGPoint.j == CGPoint(0, 1))
    }
    
    // test geometry utilities
    @Test func testGeometryProperties() async throws {
        
        // standard unit vectors
        let i = CGPoint.i
        let j = CGPoint.j
        
        // vectors
        let p = CGPoint.polar(radius: 2, angle: .pi/3)
        let q = CGPoint.polar(radius: 2, angle: 2 * .pi/3)
        
        // unitVector
        #expect(v.unitVector.isAlmostEqual(to: CGPoint(3/5, 4/5)))
        
        // (directed angles)
        #expect(p.angle(to: q).isAlmostEqual(to: .pi / 3))
        #expect(q.angle(to: p).isAlmostEqual(to: -.pi / 3))
        #expect(p.angle(to: p).isAlmostEqual(to: 0))
        #expect(i.angle(to: j).isAlmostEqual(to: .pi / 2))
        #expect(j.angle(to: i).isAlmostEqual(to: -.pi / 2))
        #expect(i.angle(to: -i).isAlmostEqual(to: .pi))
        #expect((-i).angle(to: i).isAlmostEqual(to: .pi))       // ⚠️ 注意：不是 -𝜋
        
        // rotations
        #expect(p.rotated(by: .pi / 3).isAlmostEqual(to: q))
        
        // polar coord
        #expect(p.isAlmostEqual(to: CGPoint(2 * cos(.pi / 3), 2 * sin(.pi / 3))))
    }
    
    @Test func testOtherUtilities() async throws {
        
        // non-proportional scale
        #expect(u.scaled(by: v).isAlmostEqual(to: CGPoint(3, 8)))
        #expect(u.divided(by: v).isAlmostEqual(to: CGPoint(1/3, 2/4)))
        
        // frame-related
        #expect(u.origin.isAlmostEqual(to: .zero))
        #expect(u.point.isAlmostEqual(to: CGPoint(1, 2)))
        #expect(u.size.isAlmostEqual(to: CGSize(1, 2)))
        
        let a: CGFloat = 0.1
        let b: CGFloat = 0.2
        
        #expect((a+b).isAlmostEqual(to: 0.3))
    }

}
