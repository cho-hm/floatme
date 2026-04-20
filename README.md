<p align="center">
  <img src="https://raw.githubusercontent.com/cho-hm/floatme/main/FloatMe/Resources/AppIcon.png" width="128" height="128" alt="FloatMe Icon">
</p>

<h1 align="center">FloatMe</h1>

<p align="center">
  <strong>macOS를 위한 플로팅 앱 스위처</strong><br>
  자주 쓰는 앱을 화면 위에 띄워두고, 클릭 한 번으로 전환하세요.
</p>

<p align="center">
  <a href="#english">English</a> · <a href="#한국어">한국어</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-15%2B-blue?style=flat-square" alt="macOS 15+">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift 5.9+">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License">
  <img src="https://img.shields.io/github/v/release/cho-hm/floatme?style=flat-square&label=Latest" alt="Latest Release">
</p>

---

<a id="한국어"></a>

## 한국어

### FloatMe가 뭔가요?

macOS의 Cmd+Tab은 앱이 많아지면 원하는 앱을 찾기 어렵습니다. Dock은 화면 아래에 고정되어 있어 접근이 불편할 때가 있습니다.

**FloatMe**는 자주 쓰는 앱들을 작은 아이콘으로 화면 위 어디든 띄워둘 수 있는 유틸리티입니다. 클릭 한 번이면 해당 앱의 모든 윈도우가 최상단으로 올라옵니다.

### 주요 기능

**플로팅 바**
- 실행 중인 앱을 가로 또는 세로로 나열
- 클릭으로 앱 전환 — 해당 앱의 모든 윈도우를 최상단으로
- 현재 포커스된 앱에 파란 도트 표시
- 앱이 많아지면 아이콘 자동 축소 (최소 20px, 최대 96px)

**편집 모드**
- 우클릭 → "편집 모드" 진입
- iOS처럼 아이콘이 흔들리며 ✕ 제거 버튼과 + 추가 버튼 등장
- 드래그로 아이콘 순서 변경

**스마트 이동**
- 핸들을 잡고 드래그하여 화면 어디든 배치
- 화면 가장자리에 가까워지면 자동으로 달라붙음 (Shift로 무시)
- 다중 모니터 간 자유 이동
- 위치 고정/해제 기능

**앱 영구 등록**
- 한 번 등록한 앱은 종료 후 재실행해도 자동 복귀
- 명시적으로 제거하지 않는 한 목록 유지

**커스터마이징**
- 배경 스타일: 블러(기본) / 다크 / 투명
- 투명도, 아이콘 크기 조절
- 활성 앱 재클릭 시 숨기기 (선택)
- Dock 아이콘 숨기기

**자동 업데이트**
- Sparkle 기반 인앱 업데이트
- 우클릭 → "업데이트 확인"

### 설치

#### DMG 다운로드 (권장)

[**최신 릴리스 다운로드**](https://github.com/cho-hm/floatme/releases/latest)

1. DMG 파일을 다운로드
2. FloatMe.app을 Applications 폴더로 이동
3. 최초 실행 시: 우클릭 → "열기"

#### 소스에서 빌드

```bash
git clone https://github.com/cho-hm/floatme.git
cd floatme
bash scripts/package.sh
open dist/FloatMe.app
```

### 사용법

| 동작 | 방법 |
|------|------|
| 앱 전환 | 아이콘 클릭 |
| 앱 추가 | 편집 모드에서 + 버튼, 또는 메뉴바 |
| 앱 제거 | 편집 모드 ✕, 우클릭 메뉴, Option+클릭 |
| 편집 모드 | 우클릭 → "편집 모드" |
| 바 이동 | 핸들 드래그 |
| 방향 전환 | 우클릭 → "방향 전환" |
| 위치 고정 | 우클릭 → "위치 고정" |
| 환경설정 | 우클릭 → "환경설정" |

### 요구사항

- macOS 15 (Sequoia) 이상
- Apple Silicon 또는 Intel Mac

---

<a id="english"></a>

## English

### What is FloatMe?

When you have many apps open, Cmd+Tab becomes a chore. The Dock sits at the bottom, sometimes hidden or far from your cursor.

**FloatMe** lets you pin your frequently used apps as small floating icons anywhere on your screen. One click brings all windows of that app to the front.

### Features

**Floating Bar**
- Pin running apps in horizontal or vertical layout
- Click to switch — brings all windows of the app to front
- Blue dot indicator for the currently focused app
- Auto-shrink icons when too many are pinned (min 20px, max 96px)

**Edit Mode**
- Right-click → "Edit Mode"
- Icons wiggle like iOS, showing ✕ (remove) and + (add) buttons
- Drag to reorder icons

**Smart Movement**
- Drag the handle to position anywhere on screen
- Auto-snap to screen edges (hold Shift to bypass)
- Free movement across multiple monitors
- Lock/unlock position

**Persistent Pinning**
- Pinned apps survive app restarts — they reappear when relaunched
- Only explicitly removed apps leave the list

**Customization**
- Background style: Blur (default) / Dark / Transparent
- Adjustable opacity and icon size
- Hide active app on re-click (optional)
- Hide Dock icon

**Auto Updates**
- Sparkle-based in-app updates
- Right-click → "Check for Updates"

### Install

#### Download DMG (Recommended)

[**Download Latest Release**](https://github.com/cho-hm/floatme/releases/latest)

1. Download the DMG file
2. Drag FloatMe.app to Applications
3. First launch: Right-click → "Open"

#### Build from Source

```bash
git clone https://github.com/cho-hm/floatme.git
cd floatme
bash scripts/package.sh
open dist/FloatMe.app
```

### Usage

| Action | How |
|--------|-----|
| Switch app | Click icon |
| Add app | + button in edit mode, or menu bar |
| Remove app | ✕ in edit mode, right-click menu, Option+Click |
| Edit mode | Right-click → "Edit Mode" |
| Move bar | Drag the handle |
| Toggle orientation | Right-click → "Toggle Orientation" |
| Lock position | Right-click → "Lock Position" |
| Preferences | Right-click → "Preferences" |

### Requirements

- macOS 15 (Sequoia) or later
- Apple Silicon or Intel Mac

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Swift 5.9+ |
| UI | SwiftUI + AppKit Hybrid |
| Floating Window | NSPanel (nonactivatingPanel) |
| App Detection | NSWorkspace Notification |
| Background | NSVisualEffectView |
| Storage | UserDefaults + Codable |
| Auto Update | Sparkle |
| Distribution | DMG |

## License

[MIT](LICENSE) — 자유롭게 사용, 수정, 배포할 수 있습니다. Free to use, modify, and distribute.
