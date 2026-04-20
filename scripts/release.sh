#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SPARKLE_BIN="$PROJECT_DIR/.build/artifacts/sparkle/Sparkle/bin"
VERSION="${1:?Usage: release.sh <version> (예: 0.2.0)}"
DMG_PATH="$PROJECT_DIR/dist/FloatMe-$VERSION.dmg"
APPCAST_PATH="$PROJECT_DIR/appcast.xml"
DOWNLOAD_URL="https://github.com/cho-hm/floatme/releases/download/v$VERSION/FloatMe-$VERSION.dmg"

echo "=== FloatMe Release v$VERSION ==="

# 1. 빌드 + 패키징
echo "[1/5] Building..."
cd "$PROJECT_DIR"
FLOATME_VERSION="$VERSION" bash scripts/package.sh


# 2. DMG 서명
echo "[2/5] Signing DMG..."
SIGNATURE=$("$SPARKLE_BIN/sign_update" "$DMG_PATH" 2>&1 | grep -o 'sparkle:edSignature="[^"]*"' | sed 's/sparkle:edSignature="//;s/"//')
LENGTH=$(stat -f%z "$DMG_PATH")
echo "    Signature: ${SIGNATURE:0:20}..."
echo "    Length: $LENGTH bytes"

# 3. appcast.xml 생성
echo "[3/5] Generating appcast.xml..."
cat > "$APPCAST_PATH" << XML
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <channel>
    <title>FloatMe</title>
    <link>https://github.com/cho-hm/floatme</link>
    <description>FloatMe 업데이트</description>
    <language>ko</language>
    <item>
      <title>Version $VERSION</title>
      <pubDate>$(date -R)</pubDate>
      <sparkle:version>$VERSION</sparkle:version>
      <sparkle:shortVersionString>$VERSION</sparkle:shortVersionString>
      <sparkle:minimumSystemVersion>15.0</sparkle:minimumSystemVersion>
      <enclosure url="$DOWNLOAD_URL"
                 length="$LENGTH"
                 type="application/octet-stream"
                 sparkle:edSignature="$SIGNATURE" />
    </item>
  </channel>
</rss>
XML

echo "    appcast.xml generated"

# 4. Git 커밋
echo "[4/5] Committing appcast.xml..."
git add appcast.xml
git commit -m "appcast.xml v$VERSION" 2>/dev/null || echo "    (no changes)"
git push origin main 2>/dev/null || echo "    (push manually: git push origin main)"

# 5. GitHub Release
echo "[5/5] Creating GitHub Release..."
gh release create "v$VERSION" "$DMG_PATH" \
    --title "FloatMe v$VERSION" \
    --notes "FloatMe v$VERSION 릴리스" \
    2>/dev/null || echo "    (release manually: gh release create v$VERSION $DMG_PATH)"

echo ""
echo "=== Release v$VERSION complete ==="
echo "  DMG: $DMG_PATH"
echo "  Appcast: $APPCAST_PATH"
