// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Swifty502",
    products: [
        .library(
            name: "Swifty502",
            targets: ["Swifty502"]),
        .executable(
            name: "SampleApp",
            targets: ["SampleApp"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Swifty502",
            dependencies: []),
        .target(
            name: "SampleApp",
            dependencies: ["Swifty502"]),
        .testTarget(
            name: "Swifty502Tests",
            dependencies: ["Swifty502"]),
    ]
)
