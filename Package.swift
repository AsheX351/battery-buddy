// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BatteryBuddy",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(name: "battery-buddy", targets: ["BatteryBuddy"])
    ],
    targets: [
        .executableTarget(
            name: "BatteryBuddy",
            dependencies: [],
            path: "Sources"
        )
    ]
)
