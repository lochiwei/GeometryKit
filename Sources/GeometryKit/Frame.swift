//
//  Frame.swift
//  GeometryKit
//
//  Created by boss on 2024/12/12.
//

// ------------------------
//      🅿️ Frame
// ------------------------

import SwiftUI

/// a type that has an `origin` and a `size`.
///
/// `CGRect` conforms to Frame automatically
/// when you import `GeometryKit`.
public protocol Frame {
    var origin: CGPoint { get }
    var size  : CGSize  { get }
}

// default behaviors
extension Frame {
    
    // MARK: - Static Properties -
    
    /// unit square: `Self.unitSquare`
    public static var unitSquare: CGRect {
        CGRect(origin: CGPoint(0,0), size: CGSize(1,1))
    }
    
    // MARK: - Length -
    
    /// absolute value of `rect.size.width`
    public var width  : CGFloat {
        // ⭐️ 注意：
        // 為了與 CGRect 傳回一樣的值，`rect.width` 是「絕對值」，
        // 與 rect.size.width 不同❗
        abs(size.width)
    }
    
    /// absolute value of `rect.size.height`
    public var height : CGFloat {
        // ⭐️ 注意：
        // 為了與 CGRect 傳回一樣的值，`rect.height` 是「絕對值」，
        // 與 rect.size.height 不同❗
        abs(size.height)
    }
    
    /// min length of two sides (absolute value)
    public var minSide: CGFloat {
        min(width, height)
    }
    
    /// max length of two sides (absolute value)
    public var maxSide: CGFloat {
        max(width, height)
    }
    
    // MARK: - x / y Coordinates -
    
    /// left bound (x-coord) of the frame
    public var minX: CGFloat {
        return min(origin.x, origin.x + size.width)
    }
    
    /// right bound (x-coord) of the frame
    public var maxX: CGFloat {
        return max(origin.x, origin.x + size.width)
    }
    
    /// midpoint (x-coord) of the width
    public var midX: CGFloat {
        origin.x + size.width / 2
    }
    
    /// top bound (y-coord) of the frame
    public var minY: CGFloat {
        return min(origin.y, origin.y + size.height)
    }
    
    /// bottom bound (y-coord) of the frame
    public var maxY: CGFloat {
        return max(origin.y, origin.y + size.height)
    }
    
    /// midpoint (y-coord) of the height
    public var midY: CGFloat {
        origin.y + size.height / 2
    }
    
    // MARK: - Centers & Corners -
    
    /// `rect.top`： top center of the frame
    public var top        : CGPoint { CGPoint(x: midX, y: minY) }
    
    /// `rect.bottom`： bottom center of the frame
    public var bottom     : CGPoint { CGPoint(x: midX, y: maxY) }
    
    /// `rect.left`： left center of the frame
    public var left       : CGPoint { CGPoint(x: minX, y: midY) }
    
    /// `rect.right`： right center of the frame
    public var right      : CGPoint { CGPoint(x: maxX, y: midY) }
    
    /// `rect.center`： center of the frame
    public var center     : CGPoint { CGPoint(x: midX, y: midY) }
    
    /// `rect.bottomLeft`： bottom left of the frame
    public var bottomLeft : CGPoint { CGPoint(x: minX, y: maxY) }
    
    /// `rect.bottomRight`： bottom right of the frame
    public var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    
    /// `rect.topLeft`： top left of the frame
    public var topLeft    : CGPoint { CGPoint(x: minX, y: minY) }
    
    /// `rect.topRight`： top right of the frame
    public var topRight   : CGPoint { CGPoint(x: maxX, y: minY) }
    
    /// corners of the frame: `[bottomLeft, bottomRight, topRight, topLeft]`
    public var corners: [CGPoint] {
        [bottomLeft, bottomRight, topRight, topLeft]
    }
    
    // MARK: - Relative Points -
    
    /// relative point (assume that the frame has been "normalized", that is origin = top-left corner and width/height are never negative.)
    ///
    /// ```
    /// rect[1,0] == rect.topRight
    /// rect[0,1] == rect.bottomLeft
    /// ```
    public subscript(_ s: CGFloat, _ t: CGFloat) -> CGPoint {
        let x = minX + s * width
        let y = minY + t * height
        return CGPoint(x: x, y: y)
    }
    
    /// relative point in rect.
    /// ```
    /// let p = CGPoint(0.5, 0.5)
    /// let rect = CGSize(6, 4)
    /// rect[p]   // CGPoint(3, 2)
    /// ```
    public subscript<V: Vector2D>(_ v: V) -> CGPoint where V.Scalar == CGFloat {
        return self[v.x, v.y]
    }
    
    // MARK: - Geometry Utilities -
    
    /// `width/height` (absolute value)
    public var aspectRatio: CGFloat { width/height }
    
    // MARK: - CGRect-related -
    
    /// `frame.rect`: convert to a CGRect
    public var rect: CGRect {
        CGRect(origin: origin, size: size)
    }
    
    /// bounding square of the frame
    public var boundingSquare: CGRect {
        let d = maxSide / 2
        let x = midX - d
        let y = midY - d
        return CGRect(x: x, y: y, width: maxSide, height: maxSide)
    }
    
    /// inscribed square of the frame
    public var inscribedSquare: CGRect {
        let d = minSide / 2
        let x = midX - d
        let y = midY - d
        return CGRect(x: x, y: y, width: minSide, height: minSide)
    }
    
    /// `frame.isAlmostEqual(to: other)` if their origins and sizes are almost equal.
    public func isAlmostEqual(to other: Self) -> Bool {
        self.origin.isAlmostEqual(to: other.origin) && self.size.isAlmostEqual(to: other.size)
    }
    
}


