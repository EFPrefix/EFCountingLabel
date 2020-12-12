// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "EFCountingLabel",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "EFCountingLabel", targets: ["EFCountingLabel"]),
    ],
    targets: [
        .target(name: "EFCountingLabel", path: "EFCountingLabel"),
    ]
)
