import AppKit

@MainActor
final class FloatingPanel: NSPanel {
    private(set) var isDragging = false
    private var dragStartMouseLocation: CGPoint?
    private var dragStartWindowOrigin: CGPoint?

    /// 핸들 히트 영역 크기 (가로=좌측 너비, 세로=상단 높이)
    var handleSize: CGFloat = 28
    /// 현재 방향 (가로: 좌측 핸들, 세로: 상단 핸들)
    var isVerticalBar = false

    var onDragEnd: ((CGPoint) -> Void)?

    init(contentRect: NSRect) {
        super.init(
            contentRect: contentRect,
            styleMask: [.nonactivatingPanel, .fullSizeContentView, .borderless],
            backing: .buffered,
            defer: false
        )

        level = .floating
        isOpaque = false
        backgroundColor = .clear
        hasShadow = true
        collectionBehavior = [.canJoinAllSpaces, .transient, .ignoresCycle]
        isMovableByWindowBackground = false
        hidesOnDeactivate = false
    }

    override var canBecomeKey: Bool { isDragging }
    override var canBecomeMain: Bool { false }

    private func isInHandle(_ event: NSEvent) -> Bool {
        guard let contentView else { return false }
        let local = contentView.convert(event.locationInWindow, from: nil)
        if isVerticalBar {
            // 세로 바 → 상단 핸들 (NSHostingView는 flipped: y=0이 상단)
            let isFlipped = contentView.isFlipped
            if isFlipped {
                return local.y <= handleSize
            } else {
                return local.y >= (contentView.bounds.height - handleSize)
            }
        } else {
            // 가로 바 → 좌측 핸들
            return local.x <= handleSize
        }
    }

    override func mouseDown(with event: NSEvent) {
        if isInHandle(event) {
            isDragging = true
            dragStartMouseLocation = NSEvent.mouseLocation
            dragStartWindowOrigin = frame.origin
        } else {
            super.mouseDown(with: event)
        }
    }

    override func mouseDragged(with event: NSEvent) {
        if isDragging, let startMouse = dragStartMouseLocation, let startOrigin = dragStartWindowOrigin {
            let current = NSEvent.mouseLocation
            setFrameOrigin(CGPoint(
                x: startOrigin.x + (current.x - startMouse.x),
                y: startOrigin.y + (current.y - startMouse.y)
            ))
        } else {
            super.mouseDragged(with: event)
        }
    }

    override func mouseUp(with event: NSEvent) {
        if isDragging {
            isDragging = false
            dragStartMouseLocation = nil
            dragStartWindowOrigin = nil
            onDragEnd?(frame.origin)
        } else {
            super.mouseUp(with: event)
        }
    }
}
