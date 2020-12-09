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
            targets: ["SampleApp"]),
        .executable(
            name: "Klaus6502Tests",
            targets: ["Klaus6502Tests"])
    ],
    dependencies: [.package(
        url: "https://github.com/apple/swift-atomics.git",
        .upToNextMinor(from:"0.0.2"))
    ],
    targets: [
        .target(
            name: "Swifty502",
            dependencies: [
                .product(name: "Atomics", package: "swift-atomics")
            ]),
        .target(
            name: "SampleApp",
            dependencies: ["Swifty502"]),
        .target(
            name: "Klaus6502Tests",
            dependencies: ["Swifty502"]),
        .testTarget(
            name: "Swifty502Tests",
            dependencies: ["Swifty502"]),
    ]
)
