---
type: index
generated_at: 2026-04-20T09:43:31.870831+09:00
source_root: /Users/hyunmin-cho/macapp/floatme/docs
language: ko
total_docs: 9
---

# AI Documentation Index

## Purpose

FloatMe는 macOS 15+에서 실행 중인 앱들을 화면 위 플로팅 아이콘 바로 띄워두고, 클릭 한 번으로 앱을 전환하는 오픈소스(MIT) 네이티브 유틸리티이다. SwiftUI + AppKit 하이브리드로 구현하며, NSPanel(nonactivatingPanel)로 포커스 비침해적 최상위 표시한다. 우클릭 편집 모드(흔들림/X/+/드래그 정렬), 핸들 드래그 이동, 화면 스냅, 배경 스타일(블러/다크/투명), 위치 고정, 활성 앱 재클릭 숨기기, Sparkle 자동 업데이트를 지원한다. DMG로 배포하며 최대 5개 앱 등록 제한(차후 유료 해제용)이 있다.

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
| **플로팅 바** | 화면 위에 항상 최상위로 떠 있는 앱 아이콘 바 |
| **편집 모드** | 우클릭으로 진입. 아이콘 흔들림/X 제거/+ 추가/드래그 정렬 |
| **핸들** | 바 좌측(가로)/상단(세로)의 드래그 영역. 호버 시 표시, 비호버 1초 후 숨김 |
| **NSPanel** | AppKit 보조 윈도우. nonactivatingPanel 스타일로 포커스 비침해적 표시 |
| **canBecomeKey** | NSPanel이 키 이벤트를 수신할지 제어. 항상 true로 설정 |
| **FirstMouseHostingView** | acceptsFirstMouse=true인 NSHostingView. 첫 클릭 즉시 수용 |
| **NSWorkspace** | macOS 앱 실행/종료 알림 + 앱 목록 감시 API |
| **NSRunningApplication** | 실행 중인 앱 객체. activate()/hide() 호출 |
| **activationPolicy** | .regular = Dock에 아이콘이 보이는 일반 앱 |
| **NSVisualEffectView** | macOS 네이티브 블러 배경 효과 |
| **UserDefaults + Codable** | 설정 영속화. 단일 JSON으로 저장 |
| **Sparkle** | macOS 오픈소스 자동 업데이트 프레임워크 |
| **appcast.xml** | Sparkle 업데이트 피드. 버전/DMG URL/서명 포함 |
| **EdDSA** | Sparkle DMG 서명 알고리즘 |
| **화면 스냅** | 가장자리 20px 이내 자동 달라붙기. Shift로 무시 |
| **자동 크기 축소** | 앱 수 증가 시 아이콘 크기 자동 축소 (최소 20px) |
| **앱 영구 등록** | 고정 목록 UserDefaults 저장. 앱 종료 시 제거 안 함, 재실행 시 복귀 |
| **위치 고정** | 우클릭 토글. 핸들 숨김 + 드래그 차단 |
| **toggleActiveApp** | 활성 앱 재클릭 시 hide() 호출 (기본 OFF) |
| **maxPinnedApps** | 최대 등록 수 5개 (차후 유료 해제용) |
