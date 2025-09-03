// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "navigator",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "navigator", targets: ["navigator"]),
    ],
    targets: [
        .executableTarget(
            name: "navigator",
            path: "navigator"
        )
    ]
)

