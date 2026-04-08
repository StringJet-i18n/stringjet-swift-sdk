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
            url: "https://github.com/StringJet-i18n/stringjet-swift-sdk/releases/download/v0.1.0/sdkKit.xcframework.zip",
            checksum: "0d5b76d5805a968e6778d6a26fcc0f485704372b630b93cd5d95a7b4656f04ad"
        ),
        .target(
            name: "StringJetBundle",
            dependencies: ["SdkKit"],
            path: "Sources/StringJetBundle"
        ),
    ]
)
