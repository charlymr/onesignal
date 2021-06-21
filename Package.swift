// swift-tools-version:5.4
// Managed by ice

import PackageDescription

let package = Package(
    name: "onesignal",
    products: [
        .library(name: "OneSignal", targets: ["OneSignal"]),
    ],
    targets: [
        .target(name: "OneSignal"),
        .testTarget(name: "OneSignalTests", dependencies: ["OneSignal"]),
    ]
)
