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
            url: "https://github.com/StringJet-i18n/stringjet-swift-sdk/releases/download/v0.3.0/sdkKit.xcframework.zip",
            checksum: "439940884667c322d6e060bf6e38e16330b25f52a6318e3c7c8a56a0a473543b"
        ),
        .target(
            name: "StringJetBundle",
            dependencies: ["SdkKit"],
            path: "Sources/StringJetBundle"
        ),
    ]
)
