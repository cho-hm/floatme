---
type: index
generated_at: 2026-04-17T14:50:10.215396+09:00
source_root: /Users/hyunmin-cho/macapp/floatme/docs
language: ko
total_docs: 9
---

# AI Documentation Index

## Purpose

FloatMe는 macOS에서 실행 중인 앱들을 화면 위에 작은 플로팅 아이콘 바로 띄워두고, 클릭 한 번으로 해당 앱의 모든 윈도우를 최상단으로 전환하는 오픈소스(MIT) 네이티브 앱이다. SwiftUI + AppKit 하이브리드로 구현하며, NSPanel(nonactivatingPanel)을 사용해 포커스 간섭 없이 항상 최상위에 표시한다. iOS 홈화면과 유사한 편집 모드(Long Press → 흔들림/X/+/드래그 정렬)를 핵심 UX로 채택했고, 자동 크기 축소, 화면 가장자리 스냅, 다중 모니터 이동을 지원한다. macOS 15+ 대상, DMG로 배포하며 Sparkle로 자동 업데이트한다.

## Documents

### Product Requirements
- [FloatMe](./prd.md) — prd

### Architectural Decisions
- [FloatMe 기술백서 (ADR)](./technical-decisions.md) — adr

### API & Data
- [FloatMe 데이터 정의](./api-definition.md) — api

### User Stories
- [FloatMe User Stories](./user-stories.md) — story

### Wireframes
- [FloatMe Wireframe](./Wireframe/index.md) — wireframe
- [1. 플로팅 바 (Floating Bar)](./Wireframe/sections/01-floating-bar.md) — wireframe
- [2. 앱 선택 팝업 (App Selector)](./Wireframe/sections/02-app-selector.md) — wireframe
- [3. 설정 (Settings)](./Wireframe/sections/03-settings.md) — wireframe

### Other
- [FloatMe — 스펙 결정 사항 (인터뷰 결과)](./SPEC-DECISIONS.md) — other

## Reading Order for AI

1. **INDEX** (이 문서) — 전체 맵
2. **PRD** — 제품 목적과 전체 맥락
3. **ADR** — 핵심 아키텍처 결정
4. **API Definition** — 시스템 경계와 계약
5. **Requirements** — 기능별 상세
6. **Wireframes** — UI 맥락
7. **Stories** — 동작 시나리오

## Glossary

| 용어 | 설명 |
|------|------|
| **플로팅 바 (Floating Bar)** | 화면 위에 항상 최상위로 떠 있는 앱 아이콘 바 |
| **편집 모드 (Edit Mode)** | 0.5초 Long Press로 진입하는 모드. 아이콘 흔들림/X 제거/+ 추가/드래그 정렬 가능 |
| **NSPanel** | AppKit의 보조 윈도우 클래스. nonactivatingPanel 스타일로 포커스 비침해적 표시 |
| **canBecomeKey** | NSPanel이 키 이벤트를 수신할지 제어하는 프로퍼티. 드래그 시에만 true |
| **NSWorkspace** | macOS에서 실행 중인 앱 목록 감시 및 앱 실행/종료 알림 제공 API |
| **NSRunningApplication** | 실행 중인 개별 앱을 나타내는 객체. activate(options:)로 앱 전환 |
| **activationPolicy** | 앱의 UI 표시 방식. .regular = Dock에 아이콘이 보이는 일반 앱 |
| **NSVisualEffectView** | macOS 네이티브 블러 배경 효과 뷰 |
| **NSHostingView** | AppKit 윈도우 안에서 SwiftUI 뷰를 호스팅하는 브릿지 |
| **Bundle Identifier** | macOS 앱의 고유 식별자 (예: com.apple.dt.Xcode) |
| **UserDefaults** | macOS/iOS의 키-값 설정 저장소 |
| **Codable** | Swift의 직렬화/역직렬화 프로토콜 |
| **Sparkle** | macOS 앱용 오픈소스 자동 업데이트 프레임워크 |
| **Notarization** | Apple의 앱 공증 절차. DMG 배포 시 필수 |
| **화면 가장자리 스냅 (Edge Snap)** | 플로팅 바가 화면 가장자리 20px 이내에 오면 자동으로 달라붙는 기능 |
| **자동 크기 축소** | 앱 수 증가 시 아이콘 크기를 자동으로 줄이는 기능 (최소 20px) |
| **앱 선택 팔레트 (App Selector)** | 실행 중인 앱 목록을 보여주는 팝업. 검색/토글로 추가/제거 |
| **@AppStorage** | SwiftUI에서 UserDefaults를 바인딩하는 프로퍼티 래퍼 |
| **FloatingApp** | 플로팅 바에 고정된 개별 앱 정보 모델 (bundleIdentifier, appName, order) |
| **AppSettings** | 사용자 설정 전체를 담는 루트 Codable 모델 |
