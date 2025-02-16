// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "EFCountingLabel",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "EFCountingLabel", targets: ["EFCountingLabel"]),
    ],
    targets: [
        .target(name: "EFCountingLabel", path: "EFCountingLabel"),
    ]
)
