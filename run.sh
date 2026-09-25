#!/bin/bash
# Bygger appen och startar den i simulatorn. Kräver aldrig att Xcode öppnas.
# Användning:  ./run.sh            -> iPhone 18 Pro
#              ./run.sh "iPhone Air"  -> annan enhet (kräver iOS 27.0-runtime)
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCHEME="TraderaTestCase"
DEVICE="${1:-iPhone 18 Pro}"
BUILD_DIR="$PROJECT_DIR/build"

echo "==> Bygger $SCHEME för $DEVICE"
xcodebuild \
  -project "$PROJECT_DIR/$SCHEME.xcodeproj" \
  -scheme "$SCHEME" \
  -configuration Debug \
  -destination "platform=iOS Simulator,name=$DEVICE" \
  -derivedDataPath "$BUILD_DIR" \
  build | grep -E "error:|warning:|BUILD" || true

APP="$BUILD_DIR/Build/Products/Debug-iphonesimulator/$SCHEME.app"
BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$APP/Info.plist")

echo "==> Startar simulatorn"
xcrun simctl boot "$DEVICE" 2>/dev/null || true
open -a Simulator

echo "==> Installerar och kör $BUNDLE_ID"
xcrun simctl install booted "$APP"
xcrun simctl launch booted "$BUNDLE_ID"
echo "==> Klart"
