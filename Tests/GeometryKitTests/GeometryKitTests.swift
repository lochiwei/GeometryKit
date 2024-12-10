import Testing

@testable
import GeometryKit


// Arrange
struct Point: Vector2D {
    public typealias Scalar = Double
    var x: Double
    var y: Double
    init(x: Double, y: Double) { self.x = x; self.y = y }
}

// ---------------------
//      Test Cases
// ---------------------

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}


@Test func testVectorAddition() async throws {
    
    // ① Arragne
    let u = Point(x: 3.0, y: 4.0)
    let v = Point(x: 1.0, y: 2.0)

    // ② Act
    let result = u + v

    // ③ Assert
    #expect(result == Point(x: 4.0, y: 6.0))
}
