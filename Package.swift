// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RaspSwift",
    products: [
        .library(
            name: "RaspSwift",
            targets: ["RaspSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "5.0.1")
    ],
    targets: [
        .target(
            name: "RaspSwift",
            dependencies: ["RxSwift"],
            path: "RaspSwift")
    ]
)
