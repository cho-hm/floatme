// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FloatMe",
    platforms: [.macOS("15.0")],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.6.0")
    ],
    targets: [
        .executableTarget(
            name: "FloatMe",
            dependencies: ["Sparkle"],
            path: "FloatMe"
        )
    ]
)
