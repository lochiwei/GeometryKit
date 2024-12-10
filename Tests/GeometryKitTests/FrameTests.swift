//
//  Test.swift
//  GeometryKit
//
//  Created by boss on 2024/12/12.
//
// -----------------------------------------

// 1️⃣ Swift Testing 模組
// ⭐️ Swift Playgrounds 上不適用
import Testing


// 2️⃣ 匯入要測試的模組
@testable               // ⭐️ @testable
import GeometryKit

// -------------------------------------------

import CoreGraphics

struct FrameTests {
    
    // test values
    let rect = CGRect(x: 1, y: 2, width: -3, height: 4)

    // test Self.unitSquare
    @Test func testStaticProperties() async throws {
        let unitSquare = CGRect(x: 0, y: 0, width: 1, height: 1)
        #expect(CGRect.unitSquare.isAlmostEqual(to: unitSquare))
    }
    
    @Test func testLength() async throws {
        #expect(rect.width == 3)
        #expect(rect.height == 4)
        #expect(rect.minSide == 3)
        #expect(rect.maxSide == 4)
    }
    
    @Test func testXYCoords() async throws {
        
        // x coords
        #expect(rect.minX == -2)
        #expect(rect.maxX == 1)
        #expect(rect.midX.isAlmostEqual(to: -1/2))
        
        // y coords
        #expect(rect.minY == 2)
        #expect(rect.maxY == 6)
        #expect(rect.midY == 4)
        
    }
    
    @Test func testCorners() async throws {
        
        // centers
        #expect(rect.top.isAlmostEqual(to: CGPoint(-1/2, 2)))
        #expect(rect.bottom.isAlmostEqual(to: CGPoint(-1/2, 6)))
        #expect(rect.left.isAlmostEqual(to: CGPoint(-2, 4)))
        #expect(rect.right.isAlmostEqual(to: CGPoint(1, 4)))
        
        #expect(rect.center.isAlmostEqual(to: CGPoint(-1/2, 4)))
        
        // corners
        #expect(rect.bottomLeft.isAlmostEqual(to: CGPoint(-2, 6)))
        #expect(rect.bottomRight.isAlmostEqual(to: CGPoint(1, 6)))
        #expect(rect.topLeft.isAlmostEqual(to: CGPoint(-2, 2)))
        #expect(rect.topRight.isAlmostEqual(to: CGPoint(1, 2)))
        
        #expect(rect.corners == [rect.bottomLeft, rect.bottomRight, rect.topRight, rect.topLeft])
    }
    
    @Test func testRelativePoints() async throws {
        
        let rect = CGRect(x: -2, y: 5, width: -10, height: 6)
        let p = CGPoint(1/2, 0)
        
        #expect(rect[0.5, 0.5].isAlmostEqual(to: rect.center))
        #expect(rect[2,1].isAlmostEqual(to: CGPoint(8, 11)))
        #expect(rect[1, 0].isAlmostEqual(to: rect.topRight))
        #expect(rect[0, 1].isAlmostEqual(to: rect.bottomLeft))
        
        #expect(rect[p].isAlmostEqual(to: rect.top))
        
    }
    
    @Test func testGeometryUtilities() async throws {
        let rect = CGRect(x: 0, y: 0, width: 2, height: -3)
        #expect(rect.aspectRatio.isAlmostEqual(to: -2/3))
        
    }
    
    @Test func testCGRectRelated() async throws {
        let r = CGRect(x: 5, y: 6, width: 7, height: 8)
        #expect(r.rect.isAlmostEqual(to: CGRect(x: 5, y: 6, width: 7, height: 8)))
        #expect(r.boundingSquare.isAlmostEqual(to: CGRect(x: 4.5, y: 6, width: 8, height: 8)))
        #expect(r.inscribedSquare.isAlmostEqual(to: CGRect(x: 5, y: 6.5, width: 7, height: 7)))
    }

}
