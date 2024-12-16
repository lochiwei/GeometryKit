//
//  Polygon.swift
//  GeometryKit
//
//  Created by CHI-WEI LO on 2024/12/16.
//

import SwiftUI

// macOS 14.0 needed for fill(_:), stroke(_:antialiased:)）
@available(iOS 14.0, macOS 13.0, *)

/// regular polygon
public struct Polygon: Shape {
    
    // -------- static properties ----------
    
    /// default rotation for polygons with n sides
    private static func defaultRotation(sides n: Int) -> CGFloat {
        -.pi / 2 + (n % 2 == 0 ? .pi / CGFloat(n) : 0)
    }
    
    // -------- instance stored properties ----------
    
    private let _center: CGPoint?    // 正多邊形中心點 (可不設定)
    
    /// 正多邊形邊數
    public let sides: Int
    
    /// 正多邊形半徑(中心點到頂點距離)
    public let radius: CGFloat
    
    /// 正多邊形旋轉角
    public let rotation: CGFloat
    
    
    // -------- initialization ----------
    
    // Polygon(sides:radius:center:rotation:)
    public init(
        sides: Int,
        radius r: CGFloat,
        center c: CGPoint? = nil,        // 可不設定，由程式自行設定預設值
        rotation a: CGFloat? = nil       // 可不設定，由程式自行設定預設值
    ) {
        let n = max(sides, 3)            // 最少三邊
        self.sides = n
        self._center = c
        self.radius = r
        self.rotation = a ?? Polygon.defaultRotation(sides: n)
    }
    
    // -------- instance computed properties ----------
    
    // sides in CGFloat
    private var n: CGFloat { CGFloat(sides) }
    
    // use self._center if set, otherwise use .zero
    /// 正多邊形中心點
    public var center: CGPoint { _center ?? .zero }
    
    /// 正多邊形的頂點座標：`polygon.vertices`
    public var vertices: [CGPoint] {
        
        let d = 2 * .pi / n  // angle increment
        
        return (0..<sides).map { i in
            let a = rotation + d * CGFloat(i)
            return center + .polar(radius: radius, angle: a)
        }
    }
    
    /// 內切圓半徑 (inscribed radius)
    public var inscribedRadius: CGFloat {
        radius * cos(.pi / n)
    }
    
    //  Shape protocol requirement
    /// 正多邊形的路徑
    public func path(in rect: CGRect) -> Path {
        
        // use self._center if set, otherwise use rect.center
        let dynamicCenter = _center ?? rect.center
        
        // use the vertices of this polygon with dynamicCenter
        let polygon = Polygon(
            sides: sides, radius: radius,
            center: dynamicCenter, rotation: rotation
        )
        
        // return this polygon's path
        return Path { path in
            // move to first vertex
            path.move(to: polygon.vertices.first!)
            // connect to the rest
            for vertex in polygon.vertices.dropFirst() {
                path.addLine(to: vertex)
            }
            // close path (connet to the first)
            path.closeSubpath()
        }
        
    }// self.path(in:)

}

// preview
struct Polygon_Previews: PreviewProvider {
    static var previews: some View {
        // macOS 14.0 needed for fill(_:), stroke(_:antialiased:)）
        if #available(macOS 14.0, iOS 14.0, *) {
            Polygon(sides: 6, radius: 90)
                .fill(Color.red)
                .stroke(Color.primary, lineWidth: 2)
                .frame(width: 200, height: 200)
                .border(Color.primary)
        } else {
            Polygon(sides: 6, radius: 90)
//                        .fill(Color.red)
                .stroke(Color.primary, lineWidth: 2)
                .frame(width: 200, height: 200)
                .border(Color.primary)
        }
    }
}
