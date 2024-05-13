#!/bin/sh

# Archive for iOS Simulator
xcodebuild archive \
-scheme RevDevNetworkSDK \
-destination "generic/platform=iOS Simulator" \
-archivePath ./framework/RevDevNetworkSDK-Sim \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Archive for iOS Device
xcodebuild archive \
-scheme RevDevNetworkSDK \
-destination "generic/platform=iOS" \
-archivePath ./framework/RevDevNetworkSDK \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

DIR=$(pwd)

# Create XCFramework
xcodebuild -create-xcframework \
-framework $DIR/framework/RevDevNetworkSDK.xcarchive/Products/Library/Frameworks/RevDevNetworkSDK.framework \
-framework $DIR/framework/RevDevNetworkSDK-Sim.xcarchive/Products/Library/Frameworks/RevDevNetworkSDK.framework \
-output $DIR/RevDevNetworkSDK.xcframework
