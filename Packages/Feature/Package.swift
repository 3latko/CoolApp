// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "Feature",
            targets: ["Feature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "0.46.0"),
    ],
    targets: [
        .target(
            name: "Feature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["Feature"]),
    ]
)
