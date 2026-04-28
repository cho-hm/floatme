<p align="center">
  <img src="https://raw.githubusercontent.com/cho-hm/floatme/main/FloatMe/Resources/AppIcon.png" width="128" height="128" alt="FloatMe">
</p>

<h1 align="center">FloatMe</h1>

<p align="center">
  <strong>macOS를 위한 플로팅 앱 스위처</strong><br>
  자주 쓰는 앱을 화면 위에 띄워두고, 클릭 한 번으로 전환하세요.
</p>

<p align="center">
  🇰🇷 한국어 (현재) · <a href="README.en.md">🇺🇸 English</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-15%2B-blue?style=flat-square" alt="macOS 15+">
  <img src="https://img.shields.io/badge/Swift-6.0%2B-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift 6.0+">
  <img src="https://img.shields.io/badge/License-Proprietary-red?style=flat-square" alt="Proprietary">
  <img src="https://img.shields.io/github/v/release/cho-hm/floatme?style=flat-square&label=Latest" alt="Latest Release">
</p>

---

## FloatMe가 뭔가요?

macOS의 Cmd+Tab은 앱이 많아지면 원하는 앱을 찾기 어렵습니다. Dock은 화면 아래에 고정되어 있어 접근이 불편할 때가 있습니다.

**FloatMe**는 자주 쓰는 앱들을 작은 아이콘으로 화면 위 어디든 띄워둘 수 있는 유틸리티입니다. 클릭 한 번이면 해당 앱의 모든 윈도우가 최상단으로 올라옵니다.

## 주요 기능

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
- 최대 5개 앱까지 등록 가능

**커스터마이징**
- 배경 스타일: 블러(기본) / 다크 / 투명
- 배경 투명도(50-100%), 아이콘 크기(20-96px) 조절
- 활성 앱 재클릭 시 숨기기 (선택)
- 전체화면에서 자동 숨김 (기본 ON)
- 로그인 시 자동 시작
- Dock 아이콘 숨기기

**메뉴바**
- 메뉴바 아이콘에서 빠른 접근: 플로팅 바 표시(⌘⇧F), 앱 추가(⌘⇧A), 환경설정(⌘,)

**자동 업데이트**
- Sparkle 기반 인앱 업데이트
- 우클릭 → "업데이트 확인"

## 설치

### DMG 다운로드 (권장)

[**최신 릴리스 다운로드**](https://github.com/cho-hm/floatme/releases/latest)

1. DMG 파일을 다운로드
2. FloatMe.app을 Applications 폴더로 이동
3. 최초 실행 시: 우클릭 → "열기"

### 소스에서 빌드

```bash
git clone https://github.com/cho-hm/floatme.git
cd floatme
bash scripts/package.sh
open dist/FloatMe.app
```

## 사용법

| 동작 | 방법 |
|------|------|
| 앱 전환 | 아이콘 클릭 |
| 앱 추가 | 편집 모드 + 버튼, 메뉴바 "앱 추가..." (⌘⇧A) |
| 앱 제거 | 편집 모드 ✕, 우클릭 "플로팅에서 제거", Option+클릭 |
| 편집 모드 | 우클릭 → "편집 모드" |
| 바 이동 | 핸들 드래그 (Shift 누르면 스냅 무시) |
| 바 표시/숨김 | 메뉴바 → "플로팅 바 표시" (⌘⇧F) |
| 방향 전환 | 우클릭 또는 메뉴바 → "방향 전환" |
| 위치 고정 | 우클릭 → "위치 고정" / "고정 해제" |
| 환경설정 | 우클릭 또는 메뉴바 → "환경설정..." (⌘,) |
| 업데이트 확인 | 우클릭 → "업데이트 확인..." |

## 요구사항

- macOS 15 (Sequoia) 이상
- Apple Silicon 또는 Intel Mac

## 기술 스택

| 레이어 | 기술 |
|--------|------|
| Language | Swift 6.0+ (Xcode 16+) |
| UI | SwiftUI + AppKit Hybrid |
| Floating Window | NSPanel (nonactivatingPanel) |
| App Detection | NSWorkspace Notification |
| Background | NSVisualEffectView |
| Storage | UserDefaults + Codable |
| Auto Update | Sparkle |
| Distribution | DMG |

## 라이선스

[Proprietary](LICENSE) — 소스 코드는 열람 가능하나, 수정/재배포/상업적 사용은 금지됩니다. 개인 비상업적 사용만 허용.
