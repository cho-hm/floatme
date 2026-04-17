import AppKit
import SwiftUI
import Observation

@MainActor
@Observable
final class PanelController {
    let panel: FloatingPanel
    var isVisible = true

    init() {
        panel = FloatingPanel(contentRect: NSRect(x: 100, y: 100, width: 200, height: 60))
    }

    func setContentView<V: View>(_ view: V) {
        let hostingView = FirstMouseHostingView(rootView: view)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        panel.contentView = hostingView
    }

    func show() {
        panel.orderFrontRegardless()
        isVisible = true
    }

    func hide() {
        panel.orderOut(nil)
        isVisible = false
    }

    func toggle() {
        isVisible ? hide() : show()
    }

    func updatePosition(_ point: CGPoint) {
        panel.setFrameOrigin(point)
    }

    func updateSize(_ size: CGSize) {
        var frame = panel.frame
        frame.size = size
        panel.setFrame(frame, display: true, animate: true)
    }
}

/// 첫 클릭을 즉시 수용하는 NSHostingView
final class FirstMouseHostingView<Content: View>: NSHostingView<Content> {
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool { true }
}
