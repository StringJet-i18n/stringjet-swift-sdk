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
            url: "https://github.com/StringJet-i18n/stringjet-swift-sdk/releases/download/v0.2.1/sdkKit.xcframework.zip",
            checksum: "f4a2215a0b71b15988f004c143224dd5dbb37925e0ee0b67b0b71153f6e9b866"
        ),
        .target(
            name: "StringJetBundle",
            dependencies: ["SdkKit"],
            path: "Sources/StringJetBundle"
        ),
    ]
)
