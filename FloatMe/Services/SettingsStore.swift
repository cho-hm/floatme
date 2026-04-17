import Foundation
import Observation

@MainActor
@Observable
final class SettingsStore {
    private static let key = "com.floatme.settings"
    private let defaults: UserDefaults

    var settings: AppSettings {
        didSet { save() }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        if let data = defaults.data(forKey: Self.key),
           let decoded = try? JSONDecoder().decode(AppSettings.self, from: data) {
            self.settings = decoded
        } else {
            self.settings = .default
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        defaults.set(data, forKey: Self.key)
    }

    func addApp(_ bundleId: String, name: String) {
        guard !settings.pinnedApps.contains(where: { $0.bundleIdentifier == bundleId }) else { return }
        let order = settings.pinnedApps.count
        settings.pinnedApps.append(FloatingApp(bundleIdentifier: bundleId, appName: name, order: order))
    }

    func removeApp(_ bundleId: String) {
        settings.pinnedApps.removeAll { $0.bundleIdentifier == bundleId }
        reindex()
    }

    func toggleApp(_ bundleId: String, name: String) {
        if settings.pinnedApps.contains(where: { $0.bundleIdentifier == bundleId }) {
            removeApp(bundleId)
        } else {
            addApp(bundleId, name: name)
        }
    }

    func reorderApps(_ apps: [FloatingApp]) {
        settings.pinnedApps = apps
        reindex()
    }

    func updateBarPosition(_ point: CGPoint) {
        settings.barPositionX = point.x
        settings.barPositionY = point.y
    }

    private func reindex() {
        for i in settings.pinnedApps.indices {
            settings.pinnedApps[i].order = i
        }
    }
}
