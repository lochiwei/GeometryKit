//
//  Vector.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/10.
//

// History:
// • 2024.12.09 - draft
//

// Inheritance Hierarchy
// • MetricSpace -> Vector -> Vector2D -> ComplextNumber

// ---------------------
//      🅿️ Vector
// ---------------------

/// 廣義向量協定
public protocol Vector: Equatable, MetricSpace {
    
    // constants
    
    // zero vector
    static var zero: Self { get }
    
    // ⭐️ 反向量、向量加減法、純量積
    // ---------------------------------------
    
    /// 加法反元素: -v
    static prefix func - (u: Self) -> Self
    
    /// 向量加法：u + v
    static func + (u: Self, v: Self) -> Self
    
    /// 向量減法：u - v
    static func - (u: Self, v: Self) -> Self
    
    /// 純量積：u * a
    /// (a * u: default behavior provided = u * a)
    static func * (u: Self, a: Scalar) -> Self
    
    /// 純量積：u / a
    /// (default behavior provided = u * (1/a))
    static func / (u: Self, a: Scalar) -> Self
}

// -----------------------------------
//      🌀 Vector default behaviors
// -----------------------------------

public extension Vector {
    
    // 純量積：a * u
    static func * (a: Scalar, u: Self) -> Self {
        return u * a
    }
    
    // 純量積：u / a
    static func / (u: Self, a: Scalar) -> Self {
        precondition(a != 0, "⛔ Division by zero is not allowed.")
        return u * (1/a)
    }
    
}
