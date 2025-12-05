// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LSExtensions",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LSExtensions",
            targets: ["LSExtensions"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LSExtensions",
            path: "LSExtensions",
            exclude: ["LSExtensions.h", 
                      "Info.plist",
                      "Readme",
                      "Extensions/Objc"]),
        .testTarget(
            name: "LSExtensionsTests",
            dependencies: ["LSExtensions"]),
    ]
)
