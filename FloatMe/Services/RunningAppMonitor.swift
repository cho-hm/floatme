import AppKit
import Observation

@MainActor
@Observable
final class RunningAppMonitor {
    var runningApps: [RunningAppInfo] = []
    var activeAppBundleId: String?

    private let workspace = NSWorkspace.shared
    private let selfBundleId = Bundle.main.bundleIdentifier ?? ""

    init() {
        refreshAppList()
        observeWorkspace()
    }

    private func refreshAppList() {
        runningApps = workspace.runningApplications
            .filter { $0.activationPolicy == .regular }
            .filter { $0.bundleIdentifier != selfBundleId }
            .compactMap { app in
                guard let bundleId = app.bundleIdentifier else { return nil }
                return RunningAppInfo(
                    bundleIdentifier: bundleId,
                    localizedName: app.localizedName ?? bundleId,
                    icon: app.icon ?? NSImage(systemSymbolName: "app", accessibilityDescription: nil)!,
                    app: app
                )
            }

        if let active = workspace.frontmostApplication?.bundleIdentifier {
            activeAppBundleId = active
        }
    }

    private func observeWorkspace() {
        let nc = workspace.notificationCenter

        nc.addObserver(forName: NSWorkspace.didLaunchApplicationNotification, object: nil, queue: .main) { [weak self] _ in
            self?.refreshAppList()
        }
        nc.addObserver(forName: NSWorkspace.didTerminateApplicationNotification, object: nil, queue: .main) { [weak self] _ in
            self?.refreshAppList()
        }
        nc.addObserver(forName: NSWorkspace.didActivateApplicationNotification, object: nil, queue: .main) { [weak self] notification in
            if let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication {
                self?.activeAppBundleId = app.bundleIdentifier
            }
        }
    }

    func activateApp(_ bundleId: String) {
        guard let app = runningApps.first(where: { $0.bundleIdentifier == bundleId })?.app else { return }
        // .app 번들에서도 동작하도록 unhide 후 activate
        app.unhide()
        app.activate()
        // fallback: NSWorkspace로 앱 URL 열기
        if let url = app.bundleURL {
            NSWorkspace.shared.open(url)
        }
    }
}
