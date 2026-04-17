#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_NAME="FloatMe"
BUNDLE_ID="com.floatme.app"
VERSION="0.1.0"
BUILD_DIR="$PROJECT_DIR/.build/release"
DIST_DIR="$PROJECT_DIR/dist"
APP_BUNDLE="$DIST_DIR/$APP_NAME.app"
DMG_PATH="$DIST_DIR/$APP_NAME-$VERSION.dmg"

echo "=== Packaging $APP_NAME v$VERSION ==="

# 1. Release 빌드
echo "[1/4] Building release..."
cd "$PROJECT_DIR"
swift build -c release 2>&1 | tail -3

# 2. .app 번들 구조 생성
echo "[2/4] Creating .app bundle..."
rm -rf "$DIST_DIR"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# 바이너리 복사
cp "$BUILD_DIR/$APP_NAME" "$APP_BUNDLE/Contents/MacOS/$APP_NAME"

# Sparkle 프레임워크 복사
if [ -d "$BUILD_DIR/Sparkle.framework" ]; then
    mkdir -p "$APP_BUNDLE/Contents/Frameworks"
    cp -R "$BUILD_DIR/Sparkle.framework" "$APP_BUNDLE/Contents/Frameworks/"
fi

# Info.plist 생성
cat > "$APP_BUNDLE/Contents/Info.plist" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>CFBundleShortVersionString</key>
    <string>$VERSION</string>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>LSMinimumSystemVersion</key>
    <string>15.0</string>
    <key>LSUIElement</key>
    <false/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
PLIST

# 아이콘 복사
ICON_SRC="$PROJECT_DIR/FloatMe/Resources/AppIcon.icns"
if [ -f "$ICON_SRC" ]; then
    cp "$ICON_SRC" "$APP_BUNDLE/Contents/Resources/AppIcon.icns"
fi

# PkgInfo
echo -n "APPL????" > "$APP_BUNDLE/Contents/PkgInfo"

echo "    App bundle: $APP_BUNDLE"

# 3. DMG 생성
# Sparkle rpath 수정 + Ad-hoc 서명 + 격리 속성 제거
install_name_tool -add_rpath "@executable_path/../Frameworks" "$APP_BUNDLE/Contents/MacOS/$APP_NAME" 2>/dev/null
codesign --force --deep --sign - "$APP_BUNDLE" 2>/dev/null
xattr -cr "$APP_BUNDLE"

echo "[3/4] Creating DMG..."
rm -f "$DMG_PATH"
hdiutil create -volname "$APP_NAME" \
    -srcfolder "$DIST_DIR/$APP_NAME.app" \
    -ov -format UDZO \
    "$DMG_PATH" 2>&1 | grep -v "^$"

echo "[4/4] Done!"
echo ""
echo "  App: $APP_BUNDLE"
echo "  DMG: $DMG_PATH"
echo "  Size: $(du -sh "$DMG_PATH" | cut -f1)"
