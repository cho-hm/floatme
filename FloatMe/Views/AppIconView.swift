import SwiftUI

extension Notification.Name {
    static let openSettings = Notification.Name("com.floatme.openSettings")
}

struct AppIconView: View {
    let app: FloatingApp
    let icon: NSImage?
    let isFocused: Bool
    let anyFocused: Bool
    let iconSize: CGFloat
    let isEditMode: Bool
    var onTap: () -> Void
    var onOptionTap: () -> Void
    var onRemove: () -> Void
    var onToggleEditMode: () -> Void
    var onToggleOrientation: () -> Void

    @State private var isHovering = false
    @State private var lastTapTime: Date = .distantPast
    @State private var wigglePhase = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            iconWithIndicator
                .animation(.easeInOut(duration: 0.25), value: anyFocused)

            if isEditMode {
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.white, .red)
                }
                .buttonStyle(.plain)
                .offset(x: -4, y: -4)
            }
        }
        .onHover { isHovering = $0 }
        .help(app.appName)
        .onTapGesture {
            if NSEvent.modifierFlags.contains(.option) {
                onOptionTap()
            } else if !isEditMode {
                debounceActivate()
            }
        }
        .contextMenu {
            Button("편집 모드") { onToggleEditMode() }
            Divider()
            Button("방향 전환") { onToggleOrientation() }
            Button("환경설정...") {
                NotificationCenter.default.post(name: .openSettings, object: nil)
            }
            Divider()
            Button("플로팅에서 제거") { onRemove() }
            Divider()
            Button("종료") { NSApplication.shared.terminate(nil) }
        }
    }

    @ViewBuilder
    private var iconWithIndicator: some View {
        VStack(spacing: 3) {
            iconImage
            if anyFocused {
                dot
            }
        }
    }

    private var iconImage: some View {
        Image(nsImage: icon ?? NSImage(systemSymbolName: "app", accessibilityDescription: nil)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .clipShape(RoundedRectangle(cornerRadius: iconSize * 0.2))
            .rotationEffect(.degrees(isEditMode ? (wigglePhase ? -0.4 : 0.4) : 0))
            .onChange(of: isEditMode) { _, active in
                if active { startWiggle() }
            }
            .onAppear { if isEditMode { startWiggle() } }
    }

    private var dot: some View {
        Circle()
            .fill(isFocused ? Color.blue : Color.clear)
            .frame(width: 5, height: 5)
    }

    private func startWiggle() {
        withAnimation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
            wigglePhase.toggle()
        }
    }

    private func debounceActivate() {
        let now = Date()
        guard now.timeIntervalSince(lastTapTime) > 0.2 else { return }
        lastTapTime = now
        onTap()
    }
}
