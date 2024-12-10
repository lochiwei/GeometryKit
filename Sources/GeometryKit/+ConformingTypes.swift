//
//  +Conformances.swift
//  GeometryKit
//
//  Created by boss on 2024/12/12.
//


// conforming types
// CGFloat: https://developer.apple.com/documentation/corefoundation/cgfloat
// CGRect: https://developer.apple.com/documentation/corefoundation/cgrect

import SwiftUI

// MARK: - 1D Types -

// CGFloat + MetricSpace
extension CGFloat: MetricSpace {
    public typealias Scalar = CGFloat
    // CGFloat has its own .distance(to:) method:
    // https://developer.apple.com/documentation/corefoundation/cgfloat/1645824-distance
}

// MARK: - Vector2D Types -

// 🌀CGPoint + 🅿️ Vector2D
extension CGPoint: Vector2D {
    public typealias Scalar = CGFloat
}

// 🌀CGSize + 🅿️ Vector2D
extension CGSize: Vector2D {
    public typealias Scalar = CGFloat
    public var x: CGFloat { width }
    public var y: CGFloat { height }
    public init(x: CGFloat, y: CGFloat) {
        self.init(width: x, height: y)
    }
}

// MARK: - Frame Types -

// 🌀CGRect + 🅿️ Frame
extension CGRect: Frame { }

// 🌀GeometryProxy + Frame
@available(iOS 13, macOS 10.15, *)
extension GeometryProxy: Frame {
    public var origin: CGPoint { .zero }
}

// the following conforms to `Rectangular` automatically
// 🌀CGSize + 🅿️ Rectangular
// 🌀CGPoint + 🅿️ Rectangular
// 🌀UnitPoint + 🅿️ Rectangular
