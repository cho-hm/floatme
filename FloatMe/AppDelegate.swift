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

        NotificationCenter.default.addObserver(forName: .openSettings, object: nil, queue: .main) { [weak self] _ in
            self?.openSettings()
        }

        setupAutoRemove()
        registerGlobalHotkeys()
    }

    private func setupAutoRemove() {
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didTerminateApplicationNotification,
            object: nil, queue: .main
        ) { [weak self] notification in
            guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
                  let bundleId = app.bundleIdentifier else { return }
            Task { @MainActor in
                self?.store.removeApp(bundleId)
            }
        }
    }

    private func registerGlobalHotkeys() {
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard event.modifierFlags.contains([.command, .shift]) else { return }
            switch event.keyCode {
            case 3: // F
                self?.panelController.toggle()
            case 0: // A
                self?.openAppSelector()
            default: break
            }
        }

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard event.modifierFlags.contains([.command, .shift]) else { return event }
            switch event.keyCode {
            case 3:
                self?.panelController.toggle()
                return nil
            case 0:
                self?.openAppSelector()
                return nil
            default: return event
            }
        }
    }

    func openAppSelector() {
        if selectorWindow == nil {
            let view = AppSelectorView(store: store, monitor: monitor)
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 260, height: 340),
                styleMask: [.titled, .closable],
                backing: .buffered, defer: false
            )
            window.contentView = NSHostingView(rootView: view)
            window.title = "앱 추가"
            window.center()
            selectorWindow = window
        }
        selectorWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }

    func openSettings() {
        if settingsWindow == nil {
            let view = SettingsView(store: store)
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 380, height: 400),
                styleMask: [.titled, .closable],
                backing: .buffered, defer: false
            )
            window.contentView = NSHostingView(rootView: view)
            window.title = "FloatMe 설정"
            window.center()
            settingsWindow = window
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }
}
