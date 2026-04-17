import AppKit
import SwiftUI

@MainActor
final class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem?
    private var store: SettingsStore
    private var panelController: PanelController
    private var monitor: RunningAppMonitor
    private var appDelegate: AppDelegate?

    init(store: SettingsStore, panelController: PanelController, monitor: RunningAppMonitor, appDelegate: AppDelegate) {
        self.store = store
        self.panelController = panelController
        self.monitor = monitor
        self.appDelegate = appDelegate
        super.init()
        setupStatusItem()
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "square.grid.3x3.topleft.filled", accessibilityDescription: "FloatMe")
        }

        let menu = NSMenu()

        let toggleItem = NSMenuItem(title: "플로팅 바 표시", action: #selector(togglePanel), keyEquivalent: "f")
        toggleItem.keyEquivalentModifierMask = [.command, .shift]
        toggleItem.target = self
        menu.addItem(toggleItem)

        menu.addItem(.separator())

        let orientationItem = NSMenuItem(title: "방향 전환", action: #selector(toggleOrientation), keyEquivalent: "")
        orientationItem.target = self
        menu.addItem(orientationItem)

        let addAppItem = NSMenuItem(title: "앱 추가...", action: #selector(openAppSelector), keyEquivalent: "a")
        addAppItem.keyEquivalentModifierMask = [.command, .shift]
        addAppItem.target = self
        menu.addItem(addAppItem)

        menu.addItem(.separator())

        let settingsItem = NSMenuItem(title: "환경설정...", action: #selector(openSettings), keyEquivalent: ",")
        settingsItem.target = self
        menu.addItem(settingsItem)

        menu.addItem(.separator())

        let quitItem = NSMenuItem(title: "종료", action: #selector(quit), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem?.menu = menu
    }

    @objc private func togglePanel() {
        panelController.toggle()
    }

    @objc private func toggleOrientation() {
        store.settings.orientation = store.settings.orientation == .horizontal ? .vertical : .horizontal
    }

    @objc private func openAppSelector() {
        appDelegate?.openAppSelector()
    }

    @objc private func openSettings() {
        appDelegate?.openSettings()
    }

    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
}
