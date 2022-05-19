// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkAPI",
    platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)],
    products: [
        .library(name: "NetworkAPI", targets: ["NetworkAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
    ],
    targets: [
        .target(
            name: "NetworkAPI",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "NetworkAPITests",
            dependencies: ["NetworkAPI"]),
    ]
)
