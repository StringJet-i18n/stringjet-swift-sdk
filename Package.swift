// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OtaSdk",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "OtaSdk",
            targets: ["SdkKit", "StringJetBundle"]
        ),
        .library(
            name: "StringJetBundle",
            targets: ["StringJetBundle"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SdkKit",
            url: "https://github.com/StringJet-i18n/stringjet-swift-sdk/releases/download/v0.2.0/sdkKit.xcframework.zip",
            checksum: "f2d2a759e0bb743d2ba0d2dd5179711486c85181d2771c6e7485d5c20b75d5a9"
        ),
        .target(
            name: "StringJetBundle",
            dependencies: ["SdkKit"],
            path: "Sources/StringJetBundle"
        ),
    ]
)
