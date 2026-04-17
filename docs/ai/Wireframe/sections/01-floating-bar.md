---
type: wireframe
id: wireframe-sections-01-floating-bar
title: "1. 플로팅 바 (Floating Bar)"
source: ../../../Wireframe/sections/01-floating-bar.html
related: []
tags: [floating-bar, edit-mode, horizontal, vertical, context-menu, active-indicator]
---

1. 플로팅 바 — FloatMe       
   
 
 

# 1. 플로팅 바 (Floating Bar)
 
FloatMe — v0.1 — 2026-04-17
 
  
 

## 1.1 가로 레이아웃 (Horizontal) — 일반 모드
    
| 시스템 | FloatMe | 화면구분 | Floating |
|------|------|------|------|
| URL | N/A (네이티브 윈도우) | 화면 ID | FM-FL-01-001 |

 
 
 
 1  
 2 
Xc
 

 
 
 
Sa
 

 
 
 
Fi
 

 
 
 3 
Sl
 

 
 
 
 
   
 플로팅 바 컨테이너 앱 아이콘 + 실행 도트 현재 포커스 앱 하이라이트 
 
| No | Description |
|------|------|
| 1 | — 블러 배경(NSVisualEffectView, 기본) 또는 사용자 선택 스타일. 라운드 코너, 드롭 쉐도우. Cmd+드래그로 전체 이동. 화면 가장자리 스냅(20px). 앱 수 증가 시 아이콘 자동 축소(최소 20px). |
| 2 | — 실제 앱 아이콘(NSImage) 표시. 하단에 파란 도트로 실행 중 표시. 마우스 호버 시 앱 이름 툴팁. 클릭 시 해당 앱의 모든 윈도우 활성화. Option+클릭 시 즉시 제거. |
| 3 | — 현재 최전면 앱에 파란 테두리(2px ring). didActivateApplication 알림으로 실시간 갱신. 도트와 테두리 병행 표시. |

 
 
 
  
 

## 1.2 세로 레이아웃 (Vertical)
    
| 시스템 | FloatMe | 화면구분 | Floating |
|------|------|------|------|
| URL | N/A | 화면 ID | FM-FL-01-002 |

 
 
 
 1 
 
Xc
 

 
 
 
Sa
 

 
 
 
Fi
 

 
 
 
Sl
 

 
 
 
 
   
 세로 플로팅 바 
 
| No | Description |
|------|------|
| 1 | — 가로와 동일 기능, 아이콘이 위→아래로 배치. 도트는 우측에 표시. 화면 좌/우 가장자리에 배치 시 유용. 설정에서 방향 전환 가능. |

 
 
 
  
 

## 1.3 편집 모드 (Edit Mode)
    
| 시스템 | FloatMe | 화면구분 | Floating (Edit) |
|------|------|------|------|
| URL | N/A | 화면 ID | FM-FL-01-003 |

 
 
 
 1  
 2 
×
 
Xc
 
 
 
×
 
Sa
 
 
 
×
 
Fi
 
 
 
×
 
Sl
 
  
 3 
+
 
 
 
 
   
 편집 모드 컨테이너 제거 버튼 (×) 추가 버튼 (+) 
 
| No | Description |
|------|------|
| 1 | — 0.5초 길게 누르면 진입. 바 테두리가 파란색으로 변경되어 편집 모드임을 표시. 아이콘이 iOS처럼 미세하게 흔들리는 애니메이션. 바 밖 클릭 또는 ESC로 종료. |
| 2 | — 각 아이콘 좌상단에 빨간 원형 X 버튼 표시. 클릭 시 축소+페이드아웃 애니메이션으로 즉시 제거. 나머지 아이콘 재정렬. 아이콘 드래그로 순서 변경 가능. |
| 3 | — 편집 모드에서만 나타남. 파란 점선 테두리. 클릭 시 앱 선택 팔레트 표시. 메뉴바나 Cmd+Shift+A로도 팔레트 접근 가능. |

 
 
 
  
 

## 1.4 컨텍스트 메뉴 (Context Menu)
    
| 시스템 | FloatMe | 화면구분 | Popup |
|------|------|------|------|
| URL | N/A | 화면 ID | FM-FL-01-004 |

 
 
 
 
Xc
 
 1 
 
 Xcode 
 

 
 2 플로팅에서 제거 
 
 3 Option+클릭으로 빠른 제거 
 
 
 
 
 
   
 컨텍스트 메뉴 플로팅에서 제거 단축키 안내 
 
| No | Description |
|------|------|
| 1 | — 우클릭 시 표시. macOS NSMenu 네이티브 스타일. |
| 2 | — 편집 모드 외에도 우클릭으로 제거 가능. |
| 3 | — Option+클릭 빠른 제거 힌트. |