import SwiftUI

struct FloatingBarView: View {
    var store: SettingsStore
    var monitor: RunningAppMonitor
    var panelController: PanelController
    @State var editMode = EditModeManager()
    @State private var isBarHovering = false
    @State private var showHandle = false
    @State private var handleHoverTimer: Timer?

    private var isHorizontal: Bool { store.settings.orientation == .horizontal }

    private var effectiveIconSize: CGFloat {
        let count = CGFloat(visibleApps.count + (editMode.isActive ? 1 : 0))
        guard count > 0 else { return CGFloat(store.settings.iconSize) }
        let baseSize = CGFloat(store.settings.iconSize)
        let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1200, height: 800)
        let maxBarLength = (isHorizontal ? screenFrame.width : screenFrame.height) * 0.8
        let itemLength = baseSize + 14
        let totalLength = count * itemLength
        if totalLength > maxBarLength {
            return max(20, maxBarLength / count - 14)
        }
        return baseSize
    }

    var body: some View {
        Group {
            if isHorizontal {
                horizontalLayout
            } else {
                verticalLayout
            }
        }
        .padding(8)
        .background(backgroundView)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 6, y: 2)
        .animation(.easeInOut(duration: 0.3), value: showHandle)
        .onHover { onBarHoverChanged($0) }
        .onAppear {
            setupPanelCallbacks()
            editMode.setupExitMonitors(panel: panelController.panel)
        }
        .onChange(of: store.settings.orientation) { _, _ in
            panelController.panel.isVerticalBar = !isHorizontal
        }
        .onChange(of: store.settings.barLocked) { _, newValue in
            panelController.panel.isLocked = newValue
        }
    }

    // MARK: - 가로 모드: [핸들 | 아이콘들 | (+)]

    private var horizontalLayout: some View {
        HStack(spacing: 0) {
            handle(isVerticalBar: false)
            HStack(spacing: 6) {
                iconList
                addButton
            }
        }
        .frame(minHeight: effectiveIconSize + 24)
    }

    // MARK: - 세로 모드: [핸들] / [아이콘들] / [(+)]

    private var verticalLayout: some View {
        VStack(spacing: 0) {
            handle(isVerticalBar: true)
            VStack(spacing: 6) {
                iconList
                addButton
            }
        }
        .frame(minWidth: effectiveIconSize + 24)
    }

    // MARK: - 핸들

    @ViewBuilder
    private func handle(isVerticalBar: Bool) -> some View {
        if store.settings.barLocked { EmptyView() }
        else { Group {
            if isVerticalBar {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.primary.opacity(showHandle ? 0.25 : 0))
                    .frame(width: 32, height: 8)
                    .padding(.top, showHandle ? 3 : 0)
                    .padding(.bottom, showHandle ? 5 : 0)
                    .frame(height: showHandle ? nil : 0)
            } else {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.primary.opacity(showHandle ? 0.25 : 0))
                    .frame(width: 8, height: 32)
                    .padding(.leading, showHandle ? 3 : 0)
                    .padding(.trailing, showHandle ? 5 : 0)
                    .frame(width: showHandle ? nil : 0)
            }
        }
        .contentShape(Rectangle().inset(by: -4))
        .onHover { hovering in
            if hovering {
                handleHoverTimer?.invalidate()
                showHandle = true
            }
        }
        .help("드래그하여 이동")
        } // else Group
    }

    private func onBarHoverChanged(_ hovering: Bool) {
        handleHoverTimer?.invalidate()
        if !hovering {
            // 바 벗어남 → 1초 후 숨김
            handleHoverTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                Task { @MainActor in
                    showHandle = false
                }
            }
        }
    }

    // MARK: - 아이콘 목록

    /// 고정 목록 중 현재 실행 중인 앱만 표시
    private var visibleApps: [FloatingApp] {
        store.settings.pinnedApps.filter { app in
            monitor.runningApps.contains { $0.bundleIdentifier == app.bundleIdentifier }
        }
    }

    @ViewBuilder
    private var iconList: some View {
        let anyFocused = visibleApps.contains { monitor.activeAppBundleId == $0.bundleIdentifier }

        ForEach(visibleApps) { app in
            let runInfo = monitor.runningApps.first { $0.bundleIdentifier == app.bundleIdentifier }

            AppIconView(
                app: app,
                icon: runInfo?.icon,
                isFocused: monitor.activeAppBundleId == app.bundleIdentifier,
                anyFocused: anyFocused,
                iconSize: effectiveIconSize,
                isEditMode: editMode.isActive,
                onTap: { monitor.activateApp(app.bundleIdentifier) },
                onOptionTap: { withAnimation { store.removeApp(app.bundleIdentifier) } },
                onRemove: { withAnimation { store.removeApp(app.bundleIdentifier) } },
                onToggleEditMode: { withAnimation(.spring(duration: 0.3)) { editMode.isActive.toggle() } },
                onToggleOrientation: { store.settings.orientation = store.settings.orientation == .horizontal ? .vertical : .horizontal },
                isLocked: store.settings.barLocked,
                onToggleLock: { store.settings.barLocked.toggle() }
            )
            .onDrag { NSItemProvider(object: app.bundleIdentifier as NSString) }
            .onDrop(of: [.text], delegate: ReorderDropDelegate(item: app, store: store))
        }
    }

    // MARK: - 추가 버튼

    @ViewBuilder
    private var addButton: some View {
        if editMode.isActive || store.settings.pinnedApps.isEmpty {
            Button(action: { editMode.showSelector = true }) {
                if store.settings.pinnedApps.isEmpty && !editMode.isActive {
                    VStack(spacing: 4) {
                        Image(systemName: "square.grid.3x3.topleft.filled")
                            .font(.system(size: 20))
                            .foregroundStyle(.secondary)
                        Image(systemName: "plus.circle")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                    .frame(width: effectiveIconSize + 8, height: effectiveIconSize + 20)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: effectiveIconSize * 0.2)
                            .fill(Color.blue.opacity(0.001))
                        RoundedRectangle(cornerRadius: effectiveIconSize * 0.2)
                            .strokeBorder(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .font(.system(size: effectiveIconSize * 0.5))
                    }
                    .frame(width: effectiveIconSize, height: effectiveIconSize)
                }
            }
            .buttonStyle(.plain)
            .popover(isPresented: $editMode.showSelector) {
                AppSelectorView(store: store, monitor: monitor)
            }
            .contextMenu {
                Button("편집 모드") {
                    withAnimation(.spring(duration: 0.3)) { editMode.isActive.toggle() }
                }
            }
        }
    }

    // MARK: - 배경

    @ViewBuilder
    private var backgroundView: some View {
        switch store.settings.backgroundStyle {
        case .blur:
            VisualEffectView()
                .opacity(store.settings.backgroundOpacity)
        case .dark:
            Color.black.opacity(store.settings.backgroundOpacity)
        case .transparent:
            Color.clear
        }
    }

    // MARK: - 패널 콜백

    private func setupPanelCallbacks() {
        panelController.panel.isVerticalBar = !isHorizontal
        panelController.panel.isLocked = store.settings.barLocked

        panelController.panel.onDragEnd = { [store] origin in
            let size = panelController.panel.frame.size
            let screen = NSScreen.screens.first { $0.frame.contains(NSEvent.mouseLocation) } ?? NSScreen.main
            let shiftHeld = NSEvent.modifierFlags.contains(.shift)
            let snapped = (store.settings.edgeSnap && !shiftHeld)
                ? SnapCalculator.snap(origin, barSize: size, on: screen)
                : origin
            panelController.updatePosition(snapped)
            store.updateBarPosition(snapped)
        }
    }
}

// MARK: - VisualEffectView

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .hudWindow
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

// MARK: - Reorder Drop Delegate

struct ReorderDropDelegate: DropDelegate {
    let item: FloatingApp
    let store: SettingsStore

    func performDrop(info: DropInfo) -> Bool { true }

    func dropEntered(info: DropInfo) {
        guard let fromId = info.itemProviders(for: [.text]).first else { return }
        fromId.loadObject(ofClass: NSString.self) { reading, _ in
            guard let bundleId = reading as? String else { return }
            DispatchQueue.main.async {
                guard let fromIndex = store.settings.pinnedApps.firstIndex(where: { $0.bundleIdentifier == bundleId }),
                      let toIndex = store.settings.pinnedApps.firstIndex(where: { $0.bundleIdentifier == item.bundleIdentifier }),
                      fromIndex != toIndex else { return }
                withAnimation {
                    store.settings.pinnedApps.move(
                        fromOffsets: IndexSet(integer: fromIndex),
                        toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex
                    )
                }
            }
        }
    }
}
