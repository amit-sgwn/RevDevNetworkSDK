// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "RevDevNetworkSDK",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "RevDevNetworkSDK", type: .dynamic,   
            targets: ["RevDevNetworkSDK"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products from packages which this package depends on.
        .target(
            name: "RevDevNetworkSDK",
            dependencies: []
        ),
        .binaryTarget(
            name: "RevDevNetworkSDK", 
            path: "RevDevNetworkSDK.xcframework")
        .testTarget(
            name: "RevDevNetworkSDKTests",
            dependencies: ["RevDevNetworkSDK"]
        )
    ]
)

