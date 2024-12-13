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
    
    // testConformance
    @Test func test_CGSizeConformsToFrame() async throws {
        // CGSize: Frame
        let size = CGSize(width: 3, height: 2)
        #expect(size.origin == .zero)
        #expect(size.size == size)
        #expect(size.center.isAlmostEqual(to: CGPoint(3/2, 1)))
        #expect(size[2, 1].isAlmostEqual(to: CGPoint(6, 2)))
    }

    // static properties
    @Test func test_FrameStaticProperties() async throws {
        let unitSquare = CGRect(x: 0, y: 0, width: 1, height: 1)
        #expect(CGRect.unitSquare.isAlmostEqual(to: unitSquare))
    }
    
    // length
    @Test func test_FrameLengths() async throws {
        #expect(rect.width == 3)
        #expect(rect.height == 4)
        #expect(rect.minSide == 3)
        #expect(rect.maxSide == 4)
    }
    
    // x, y coords
    @Test func test_FrameXYCoords() async throws {
        
        // x coords
        #expect(rect.minX == -2)
        #expect(rect.maxX == 1)
        #expect(rect.midX.isAlmostEqual(to: -1/2))
        
        // y coords
        #expect(rect.minY == 2)
        #expect(rect.maxY == 6)
        #expect(rect.midY == 4)
        
    }
    
    // corners
    @Test func test_FrameCorners() async throws {
        
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
    
    // relative points
    @Test func test_FrameRelativePoints() async throws {
        
        let rect = CGRect(x: -2, y: 5, width: -10, height: 6)
        let p = CGPoint(1/2, 0)
        
        #expect(rect[0.5, 0.5].isAlmostEqual(to: rect.center))
        #expect(rect[2,1].isAlmostEqual(to: CGPoint(8, 11)))
        #expect(rect[1, 0].isAlmostEqual(to: rect.topRight))
        #expect(rect[0, 1].isAlmostEqual(to: rect.bottomLeft))
        
        #expect(rect[p].isAlmostEqual(to: rect.top))
        
    }
    
    // geometry utilities
    @Test func test_FrameGeometryUtilities() async throws {
        let rect = CGRect(x: 0, y: 0, width: 2, height: -3)
        #expect(rect.aspectRatio.isAlmostEqual(to: -2/3))
        
    }
    
    // CGRect-related
    @Test func test_FrameCGRectRelated() async throws {
        let r = CGRect(x: 5, y: 6, width: 7, height: 8)
        #expect(r.rect.isAlmostEqual(to: CGRect(x: 5, y: 6, width: 7, height: 8)))
        #expect(r.boundingSquare.isAlmostEqual(to: CGRect(x: 4.5, y: 6, width: 8, height: 8)))
        #expect(r.inscribedSquare.isAlmostEqual(to: CGRect(x: 5, y: 6.5, width: 7, height: 7)))
    }

}
