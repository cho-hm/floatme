## 프로젝트 개요

FloatMe — macOS 15+ 플로팅 앱 스위처. Swift 5.9 / SwiftUI + AppKit 하이브리드.

## 빌드

```bash
swift build              # 디버그
swift build -c release   # 릴리스
bash scripts/package.sh  # .app + DMG 패키징 (dist/)
```

## 릴리스

```bash
bash scripts/release.sh <version>
# 예: bash scripts/release.sh 0.2.0
# 빌드 → DMG 서명(Sparkle EdDSA) → appcast.xml 생성 → git push → GitHub Release
```

- Sparkle 공개키: `04oF4K4zcCrEV3W6NbrCOSLK9mbwovy+3bZein7OTL8=`
- 비밀키: macOS 키체인에 저장됨
- appcast.xml: 리포 루트에 위치, GitHub raw URL로 호스팅

## 아키텍처

```
FloatMe/
├── FloatMeApp.swift          @main + Settings scene
├── AppDelegate.swift         앱 생명주기 + Sparkle + 윈도우 관리
├── Models/                   데이터 모델 (AppSettings, FloatingApp, RunningAppInfo)
├── Services/                 비즈니스 로직 (SettingsStore, RunningAppMonitor, SnapCalculator)
├── Panel/                    NSPanel 플로팅 윈도우 (FloatingPanel, PanelController)
├── Views/                    SwiftUI 뷰 (FloatingBarView, AppIconView, AppSelectorView, SettingsView, EditModeManager)
├── MenuBar/                  메뉴바 (MenuBarManager)
└── Resources/                AppIcon.icns
```

## 핵심 설계 결정

- **NSPanel(nonactivatingPanel)**: 포커스 비침해적 최상위 표시
- **canBecomeKey: true**: SwiftUI 클릭 이벤트 전달에 필요
- **FirstMouseHostingView**: acceptsFirstMouse로 첫 클릭 즉시 수용
- **핸들 기반 드래그**: NSPanel mouseDown/mouseDragged에서 직접 처리 (SwiftUI 제스처 사용하지 않음)
- **앱 전환**: NSRunningApplication.activate() + NSWorkspace.open() fallback
- **앱 영구 등록**: UserDefaults에 저장, 종료 시 제거하지 않음, 실행 중인 앱만 표시
- **최대 5개 등록 제한**: SettingsStore.maxPinnedApps

## 배포

- DMG 직접 배포 (App Store 미사용)
- ad-hoc 코드 서명 + xattr 격리 제거 (scripts/package.sh에 포함)
- 정식 배포 시 Apple Developer Program($99/년) + Notarization 필요
- 라이선스: Proprietary (All Rights Reserved) — 열람만 허용, 수정/재배포/상업적 사용 금지

## 커밋 컨벤션

한글 커밋 메시지. 변경 내용을 간결하게 기술.
