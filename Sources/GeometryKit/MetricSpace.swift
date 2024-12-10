//
//  MetricSpace.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/11.
//

// Inheritance Hierarchy
// • MetricSpace -> Vector -> Vector2D -> ComplextNumber

// 🅿️ MetricSpace (protocol)
public protocol MetricSpace {
    
    // ⭐️ 純量 (scalar)
    // • FloatingPoint：支援 +,-,*,/
    // • Comparable   ：可比較大小（如需排序或限制範圍時）
    
    associatedtype Scalar: FloatingPoint & Comparable
    
    // ⭐️ requirement
    func distance(to other: Self) -> Scalar
}

// MetricSpace: default behavior
extension MetricSpace {
    
    // ⭐️ p.isAlmostEqual(to: q)
    func isAlmostEqual(
        
        to other: Self,
        
        // ⭐ 容許誤差的比較（Tolerance-based Comparison）
        // default tolerance = ULP of 1.0 * 1000
        // .ulpOne: ULP (Unit of Last Place) of 1.0.....0 <-- this place
        // • Double.ulpOfOne = 2.220446049250313e-16
        // • Float.ulpOfOne = 1.1920929e-07
        // • 在 64 位元平台上(現今大部分的 Apple 裝置)，CGFloat 與 Double 有相同精度
        tolerance: Scalar = Scalar.ulpOfOne * 1000
        
    ) -> Bool {
        return distance(to: other) < tolerance
    }
    
}

