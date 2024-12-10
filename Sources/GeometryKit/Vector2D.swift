//
//  Vector2D.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/10.
//

// Inheritance Hierarchy
// • MetricSpace -> Vector -> Vector2D -> ComplextNumber

// ---------------------
//      🅿️ Vector2D
// ---------------------

/// 通用的二維向量協定，可適用於 `CGPoint`, `CGSize` 等
///
/// ```
/// import CoreGraphics
///
/// // CGPoint + Vector2D
/// extension CGPoint: Vector2D {
///     public typealias Scalar = CGFloat
/// }
///
/// // CGSize + Vector2D
/// extension CGSize: Vector2D {
///     public typealias Scalar = CGFloat
///     public var y: CGFloat { height }
///     public init(x: CGFloat, y: CGFloat) {
///         self.init(width: x, height: y)
///     }
/// }
/// ```
public protocol Vector2D: Vector {
    
    // ⭐️ required properties
    var x: Scalar { get }
    var y: Scalar { get }
    
    // ⭐️ required initializer
    init(x: Scalar, y: Scalar)
    
}


// ------------------------------------------
//      🌀 Vector2D: Vector Operations
// ------------------------------------------

// MARK: - Vector Operations -

public extension Vector2D {
    
    /* ------- Constants ------- */
    
    /// `Self.zero = (0, 0)`
    static var zero: Self {
        return Self.init(x: 0, y: 0)
    }
    
    /// `Self.i = (1, 0)`
    static var i: Self {
        return Self.init(x: 1, y: 0)
    }
    
    /// `Self.j = (0, 1)`
    static var j: Self {
        return Self.init(x: 0, y: 1)
    }
    
    /* ------- Initializers ------- */
    
    /// convenience initializer, ex: `CGPoint(1, 2`
    init(_ x: Scalar, _ y: Scalar) {
        self.init(x: x, y: y)
    }
    
    /* ------- Geometry Properties ------- */
    
    /// 長度平方 |z|² = x² + y²
    var normSquared: Scalar {
        x * x + y * y
    }
        
    /// 長度 |z| = √(x² + y²)
    var magnitude: Scalar {
        (x * x + y * y).squareRoot()
    }
        
    /// 長度 |z|
    var norm: Scalar {
        (x * x + y * y).squareRoot()
    }
    
    /// 單位向量
    var unitVector: Self {
        precondition(self.magnitude != 0, "⛔ Zero vector can not be normalized.")
        return self / self.magnitude
    }
    
    
    /* ------- Linear Combinations ------- */
    
    /// u + v (vector addition)
    @inlinable    // 減少運算頻繁調用的開銷
    static func + (u: Self, v: Self) -> Self {
        return Self.init(x: u.x + v.x, y: u.y + v.y)
    }
    
    /// u += v (vector addition)
    static func += (u: inout Self, v: Self) {
        u = u + v
    }
    
    /// -v (additive inverse)
    static prefix func - (v: Self) -> Self {
        return Self.init(x: -v.x, y: -v.y)
    }
    
    /// u - v (vector subtraction)
    @inlinable    // 減少運算頻繁調用的開銷
    static func - (u: Self, v: Self) -> Self {
        return Self.init(x: u.x - v.x, y: u.y - v.y)
    }
    
    /// u -= v (vector subtraction)
    static func -= (u: inout Self, v: Self) {
        u = u - v
    }
    
    /* ------- Scalar Multiplication ------- */
    
    /// v * a (scalar multiplication)
    /// (a * v : default behavior provided by `Vector`)
    @inlinable    // 減少運算頻繁調用的開銷
    static func * (v: Self, a: Scalar) -> Self {
        return Self.init(x: a * v.x, y: a * v.y)
    }
    
    /// v *= a (scalar multiplicatio)
    static func *= (v: inout Self, a: Scalar) {
        v = v * a
    }
    
    // v / a (scalar multiplication)
    // default behavior provided by `Vector`
    
    /// v /= a (scalar multiplicatio)
    static func /= (v: inout Self, a: Scalar) {
        precondition(a != 0, "⛔ Division by zero is not allowed.")
        v = v / a
    }

    
    /* ------- Dot Product ------- */
        
    /// dot product
    /// u.dot(v) = u • v = u.x * v.x + u.y * v.y
    func dot(_ v: Self) -> Scalar {
        return x * v.x + y * v.y
    }
    
    /* ------- Cross Product ------- */
    
    /// cross product:
    /// u × v = u.x * v.y - u.y * v.x
    ///
    /// ```
    /// // Example:
    /// let u = CGPoint(1, 2) // u = (1, 2)
    /// let v = CGPoint(3, 4) // v = (3, 4)
    /// u.cross(v)            // u × v = -2
    /// ```
    func cross(_ v: Self) -> Scalar {
        return x * v.y - y * v.x
    }
    
}

// ---------------------------------------
//      🌀 Vector2D: Other Utilities
// ---------------------------------------

// MARK: - Utility -

public extension Vector2D {
        
    /* ------- non-proportional scale ------- */
    
    /// ```
    /// // non-proportional scale
    /// let u = CGPoint(1, 2) // u = (1, 2)
    /// let v = CGPoint(3, 4) // v = (3, 4)
    /// u.scale(v)            // (1*3, 2*4) = (3, 8)
    /// ```
    func scaled(by v: Self) -> Self {
        return Self.init(x: x * v.x, y: y * v.y)
    }
    
    /// non-proportional scale
    /// u = (a, b)
    /// v = (c, d)
    /// u.divided(by: v) = (a/c, b/d)
    func divided(by v: Self) -> Self {
        precondition(v.x != 0 && v.y != 0, "⛔ Division by zero is not allowed.")
        return Self.init(x: x / v.x, y: y / v.y)
    }

}


// ----------------------------------------------
//      🌀 Vector2D: Geometry Utilities
// ----------------------------------------------

// MARK: - Geometry -

extension Vector2D {
    
    // ⭐️ required by MetricSpace
    // p.distance(to: q)
    public func distance(to other: Self) -> Scalar {
        return (self - other).magnitude
    }
    
}


// 需要 cos(), sin(), atan2() 等等函數者放這裡
import  CoreGraphics        // for CGFloat, CGPoint , etc

// cos(), sin(), etc use CGFloat
extension Vector2D where Scalar == CGFloat {
    
    /* ------- Geometry Utilities ------- */
    
    /// 將向量旋轉某個角度 (in radians)
    /// `vector.rotated(by: angle)`
    public func rotated(by angle: Scalar) -> Self {
        let cosA = cos(angle)
        let sinA = sin(angle)
        // transformed by rotation matrix
        return Self.init(
            x: x * cosA - y * sinA,
            y: x * sinA + y * cosA
        )
    }
    
    /// u 到 v 的有向角(in radians)，
    /// 範圍：-𝜋 < θ <= 𝜋
    public func angle(to v: Self) -> Scalar {
        
        // dot = |u||v|cosθ
        let dot = self.dot(v)
        // u ⨉ v = |u||v|sinθ
        let area = self.cross(v)
        
        // |u||v|
        let mn = self.magnitude * v.magnitude
        
        precondition(mn != 0,
            "⛔ Angle to/from zero vector is not defined."
        )
        
        // (cosθ, sinθ)
        let (c, s) = (dot/mn, area/mn)
        
        // atan2(y, x)
        return atan2(s, c)
    }
    
    /* ------- Polar Coordinates ------- */
    
    // cos(x), sin(x) -> Foundation framework
    
    /// polar form: `Self.polar(radius: 2, angle: .pi/3)`
    public static func polar(radius: Scalar, angle: Scalar) -> Self {
        let (r, a) = (radius, angle)
        return Self.init(x: r * cos(a), y: r * sin(a))
    }
    
    /// convert to CGPoint: `v.point`
    public var point: CGPoint { CGPoint(x: x, y: y) }
    
    /* ------- Frame related  ------- */
    
    /// vector's origin: `v.origin == Self.zero`
    public var origin: CGPoint { .zero }
    
    /// convert to CGSize: `v.size`
    public var size  : CGSize  {  CGSize(width: x, height: y) }
}
