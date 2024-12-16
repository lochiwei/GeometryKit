// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeometryKit",
    
    // 指定 macOS 最低支援版本： 13.0
    platforms: [
            .macOS(.v13)
    ],
    
    // Products define the executables and libraries a package produces,
    // making them visible to other packages.
    products: [
        .library(
            name: "GeometryKit",
            targets: ["GeometryKit"]
        ),
    ],
    
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    targets: [
        
        .target(
            name: "GeometryKit"
        ),
        
        .testTarget(
            name: "GeometryKitTests",
            dependencies: ["GeometryKit"]
        ),
    ]
)
