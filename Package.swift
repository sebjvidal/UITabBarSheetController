// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "UITabBarSheetController",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "UITabBarSheetController",
            targets: ["UITabBarSheetController"]
        ),
    ],
    targets: [
        .target(
            name: "UITabBarSheetController"
        )
    ]
)
