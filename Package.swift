// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "EFCountingLabel",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "EFCountingLabel", targets: ["EFCountingLabel"]),
    ],
    targets: [
        .target(name: "EFCountingLabel", path: "EFCountingLabel"),
    ]
)
