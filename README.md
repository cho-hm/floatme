# FloatMe

macOS용 플로팅 앱 스위처. 실행 중인 앱을 화면 위 플로팅 아이콘으로 띄워두고, 클릭 한 번으로 전환합니다.

A floating app switcher for macOS. Pin running apps as floating icons on your screen and switch with a single click.

![macOS 15+](https://img.shields.io/badge/macOS-15%2B-blue)
![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-orange)
![License: MIT](https://img.shields.io/badge/License-MIT-green)

---

## 기능 / Features

### 플로팅 바 / Floating Bar
- 실행 중인 앱의 아이콘을 가로 또는 세로로 나열
- 클릭하면 해당 앱의 모든 윈도우가 최상단으로 올라옴
- 앱이 많아지면 아이콘이 자동으로 축소 (최소 20px)

- Pin running app icons in horizontal or vertical layout
- Click to bring all windows of that app to front
- Icons auto-shrink when too many apps are pinned (min 20px)

### 편집 모드 / Edit Mode
- 우클릭 → "편집 모드"로 진입
- iOS처럼 아이콘이 흔들리며 X 버튼과 + 버튼이 나타남
- 드래그로 아이콘 순서 변경

- Right-click → "Edit Mode" to enter
- Icons wiggle like iOS, showing X (remove) and + (add) buttons
- Drag to reorder icons

### 앱 추가/제거 / Add & Remove Apps
- **추가**: 편집 모드 + 버튼, 메뉴바, `Cmd+Shift+A`
- **제거**: 편집 모드 X 버튼, 우클릭 메뉴, `Option+클릭`, 팔레트 토글
- 앱 종료 시 플로팅에서 자동 제거

- **Add**: Edit mode + button, menu bar, `Cmd+Shift+A`
- **Remove**: Edit mode X button, right-click menu, `Option+Click`, palette toggle
- Auto-remove when app terminates

### 이동 / Move
- 왼쪽(가로) 또는 상단(세로)의 핸들을 드래그하여 이동
- 화면 가장자리 20px 이내에서 자동 스냅 (`Shift`로 무시)
- 다중 모니터 간 자유 이동

- Drag the handle (left in horizontal, top in vertical) to move
- Auto-snap to screen edges within 20px (`Shift` to bypass)
- Free movement across multiple monitors

### 기타 / Others
- 현재 포커스된 앱에 파란 도트 표시
- 배경 스타일 선택: 블러(기본) / 다크 / 투명
- 투명도 조절, 아이콘 크기 조절
- 메뉴바 아이콘으로 표시/숨김, 방향 전환, 설정 접근
- `Cmd+Shift+F`로 표시/숨김 토글

- Blue dot indicator for currently focused app
- Background style: Blur (default) / Dark / Transparent
- Adjustable opacity and icon size
- Menu bar icon for show/hide, orientation toggle, settings
- `Cmd+Shift+F` to toggle visibility

---

## 설치 / Install

### DMG (권장 / Recommended)
[Releases](https://github.com/cho-hm/floatme/releases)에서 DMG를 다운로드하여 설치합니다.

Download DMG from [Releases](https://github.com/cho-hm/floatme/releases).

### 소스 빌드 / Build from Source
```bash
git clone https://github.com/cho-hm/floatme.git
cd floatme
swift build -c release
```

패키징:
```bash
bash scripts/package.sh
# dist/FloatMe.app, dist/FloatMe-0.1.0.dmg 생성
```

---

## 요구사항 / Requirements

- macOS 15 (Sequoia) 이상 / macOS 15 (Sequoia) or later
- App Store 외부 배포 (DMG) / Distributed outside App Store (DMG)

---

## 기술 스택 / Tech Stack

| 항목 / Layer | 기술 / Tech |
|---|---|
| Language | Swift 5.9+ |
| UI | SwiftUI + AppKit Hybrid |
| Floating Window | NSPanel (nonactivatingPanel) |
| App Detection | NSWorkspace Notification |
| Background | NSVisualEffectView |
| Storage | UserDefaults + Codable |
| Auto Update | Sparkle |
| Distribution | DMG + Notarization |

---

## 단축키 / Keyboard Shortcuts

| 단축키 / Shortcut | 동작 / Action |
|---|---|
| `Cmd+Shift+F` | 플로팅 바 표시/숨김 / Toggle floating bar |
| `Cmd+Shift+A` | 앱 선택 팔레트 / Open app selector |
| `Option+Click` | 즉시 제거 / Quick remove |

---

## 라이선스 / License

[MIT](LICENSE)
