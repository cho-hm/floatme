import AppKit

struct RunningAppInfo: Identifiable, Equatable, Hashable {
    let bundleIdentifier: String
    let localizedName: String
    let icon: NSImage
    let app: NSRunningApplication

    var id: String { bundleIdentifier }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.bundleIdentifier == rhs.bundleIdentifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(bundleIdentifier)
    }
}
