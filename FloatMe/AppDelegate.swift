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

        registerGlobalHotkeys()
    }

    // 숫자키 1~0 → keyCode 매핑
    private static let numberKeyCodes: [UInt16: Int] = [
        18: 0, 19: 1, 20: 2, 21: 3, 23: 4,  // 1,2,3,4,5
        22: 5, 26: 6, 28: 7, 25: 8, 29: 9   // 6,7,8,9,0
    ]

    private func registerGlobalHotkeys() {
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyEvent(event)
        }

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if self?.handleKeyEvent(event) == true { return nil }
            return event
        }

        NotificationCenter.default.addObserver(forName: .hotkeySettingsChanged, object: nil, queue: .main) { _ in
            // 설정 변경 시 별도 재등록 불필요 — 매 이벤트에서 설정값을 실시간 체크
        }
    }

    @discardableResult
    private func handleKeyEvent(_ event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)

        // Cmd+Shift+F: 표시/숨김
        if flags.contains([.command, .shift]) && event.keyCode == 3 {
            panelController.toggle()
            return true
        }
        // Cmd+Shift+A: 앱 추가
        if flags.contains([.command, .shift]) && event.keyCode == 0 {
            openAppSelector()
            return true
        }

        // 숫자 키 핫키
        guard store.settings.hotkeyEnabled else { return false }

        var requiredFlags: NSEvent.ModifierFlags = []
        if store.settings.hotkeyUseCmd { requiredFlags.insert(.command) }
        if store.settings.hotkeyUseCtrl { requiredFlags.insert(.control) }
        if store.settings.hotkeyUseOption { requiredFlags.insert(.option) }

        guard !requiredFlags.isEmpty, flags.contains(requiredFlags) else { return false }

        if let index = Self.numberKeyCodes[event.keyCode] {
            let visibleApps = store.settings.pinnedApps.filter { app in
                monitor.runningApps.contains { $0.bundleIdentifier == app.bundleIdentifier }
            }
            if index < visibleApps.count {
                monitor.activateApp(visibleApps[index].bundleIdentifier)
                return true
            }
        }

        return false
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
