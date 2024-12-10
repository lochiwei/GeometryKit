//
//  ComplexNumber.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/10.
//

// Inheritance Hierarchy
// • MetricSpace -> Vector -> Vector2D -> ComplextNumber

// ---------------------------
//      🅿️ ComplexNumber
// ---------------------------

/// 廣義的「複數」協定
///
/// 讓一般型別(如：CGPoint)可遵循 ComplexNumber 協議，
/// 讓它們擁有複數的計算能力（如：複數乘法代表旋轉與縮放）
///
/// ```swift
/// import CoreGraphics
///
/// // 🌀CGSize + ComplexNumber
/// extension CGSize: ComplexNumber {
///
///     public typealias Scalar = CGFloat
///
///     // required properties
///     public var x: CGFloat { width }
///     public var y: CGFloat { height }
///
///     // required initializer
///     public init(x: CGFloat, y: CGFloat) {
///         self.init(width: x, height: y)
///     }
/// }
/// ```
public protocol ComplexNumber: Vector2D {
    
    // default behavior provided by Vector2D
    // • 加法反元素: -v
    // • 複數加法：u + v
    // • 複數減法：u - v
    // • 純量積：v * a, a * v, v / a
    
    // ⭐️ 複數運算
    
    /// 複數乘法：u * v
    static func * (u: Self, v: Self) -> Self
    
    /// 複數除法：u / v
    static func / (u: Self, v: Self) -> Self
    
    /// 複數除法：a / v
    static func / (a: Scalar, v: Self) -> Self
    
}

// ----------------------------------------------
//      🌀 ComplexNumber (default behaviors)
// ----------------------------------------------

public extension ComplexNumber {
    
    // default behavior provided by Vector2D
    // • u + v, u += v
    // • u - v, u -= v
    // • u * a, u *= a
    // • u / a, u /= a
    // 複數長度：
    // • normSqaured ( |z|² = x² + y²   )
    // • magnitude   ( |z| = √(x² + y²) )
    // • norm        ( = magnitude      )
    
    
    /// 共軛複數： a - bi
    var conjugate: Self {
        Self.init(x: x, y: -y)
    }
    
    /* ------- u + v, u - v ------- */
    
    /// 複數加法：a + v
    @inlinable    // 減少運算頻繁調用的開銷
    static func + (a: Scalar, v: Self) -> Self {
        Self.init(x: a + v.x, y: v.y)
    }
    
    /// 複數加法：v + a
    @inlinable    // 減少運算頻繁調用的開銷
    static func + (v: Self, a: Scalar) -> Self {
        Self.init(x: a + v.x, y: v.y)
    }
    
    // u += a
    static func += (u: inout Self, a: Scalar) {
        u = u + a
    }
    
    /// 複數減法：a - v
    @inlinable    // 減少運算頻繁調用的開銷
    static func - (a: Scalar, v: Self) -> Self {
        Self.init(x: a - v.x, y: -v.y)
    }
        
    /// 複數減法：v - a
    @inlinable    // 減少運算頻繁調用的開銷
    static func - (v: Self, a: Scalar) -> Self {
        Self.init(x: v.x - a, y: v.y)
    }
    
    // u -= a
    static func -= (u: inout Self, a: Scalar) {
        u = u - a
    }
    
    /* ------- u * v, u *= v ------- */
    
    // 複數乘法：u * v
    // u = a + bi
    // v = c + di
    // u * v = (ac-bd) + (ad+bc)i
    @inlinable    // 減少運算頻繁調用的開銷
    static func * (u: Self, v: Self) -> Self {
        let (a,b,c,d) = (u.x, u.y, v.x, v.y)
        return Self.init(x: a * c - b * d, y: a * d + b * c)
    }
    
    // u *= v
    static func *= (u: inout Self, v: Self) {
        u = u * v
    }
    
    
    /* ------- u / v, u /= v ------- */
    
    /// 複數除法：a / v
    @inlinable    // 減少運算頻繁調用的開銷
    static func / (a: Scalar, v: Self) -> Self {
        
        precondition(v.normSquared != 0,
             "⛔ Division by zero is not allowed."
        )
        
        return Self.init(x: a, y: 0) / v
    }
    
    // 複數除法：u / v
    // u = a + bi
    // v = c + di
    // u / v = (a + bi)(c - di) / (c² + d²)
    @inlinable    // 減少運算頻繁調用的開銷
    static func / (u: Self, v: Self) -> Self {
        
        precondition(v.normSquared != 0,
                     "⛔ Division by zero is not allowed."
        )
        
        return (u * v.conjugate) / v.normSquared
    }
    
    /// 複數除法：u /= v
    /// u = u / v
    static func /= (u: inout Self, v: Self) {
        precondition(v != Self.zero, "⛔ Division by zero is not allowed.")
        u = u / v
    }
    
}
