// swift-tools-version:5.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "OneSignal",
    products: [
        .library(name: "OneSignal", targets: ["OneSignal"]),
    ],
    targets: [
        .target(name: "OneSignal"),
        .testTarget(name: "OneSignalTests", dependencies: ["OneSignal"]),
    ]
)
