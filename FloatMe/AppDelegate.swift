import AppKit
import SwiftUI

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    var store: SettingsStore!
    var monitor: RunningAppMonitor!
    var panelController: PanelController!
    var menuBarManager: MenuBarManager!

    private var settingsWindow: NSWindow?
    private var selectorWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        store = SettingsStore()
        monitor = RunningAppMonitor()
        panelController = PanelController()
        menuBarManager = MenuBarManager(store: store, panelController: panelController, monitor: monitor, appDelegate: self)

        let barView = FloatingBarView(
            store: store,
            monitor: monitor,
            panelController: panelController
        )
        panelController.setContentView(barView)

        let pos = CGPoint(x: store.settings.barPositionX, y: store.settings.barPositionY)
        panelController.updatePosition(pos)
        panelController.show()

        if store.settings.hideDockIcon {
            NSApp.setActivationPolicy(.accessory)
        }

        NotificationCenter.default.addObserver(forName: .openSettings, object: nil, queue: .main) { [weak self] _ in
            Task { @MainActor in
                self?.openSettings()
            }
        }
    }

    func openAppSelector() {
        selectorWindow?.close()
        let view = AppSelectorView(store: store, monitor: monitor)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 260, height: 340),
            styleMask: [.titled, .closable],
            backing: .buffered, defer: false
        )
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: view)
        window.title = "앱 추가"
        window.center()
        selectorWindow = window
        window.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }

    func openSettings() {
        settingsWindow?.close()
        let view = SettingsView(store: store)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 380, height: 400),
            styleMask: [.titled, .closable],
            backing: .buffered, defer: false
        )
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: view)
        window.title = "FloatMe 설정"
        window.center()
        settingsWindow = window
        window.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }
}
