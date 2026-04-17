import Foundation

enum BarOrientation: String, Codable, CaseIterable {
    case horizontal
    case vertical
}

enum BackgroundStyle: String, Codable, CaseIterable {
    case blur
    case dark
    case transparent
}

struct AppSettings: Codable, Equatable {
    var pinnedApps: [FloatingApp] = []
    var barPositionX: Double = 100
    var barPositionY: Double = 100
    var orientation: BarOrientation = .horizontal
    var iconSize: Int = 36
    var backgroundOpacity: Double = 0.8
    var backgroundStyle: BackgroundStyle = .blur
    var hideInFullscreen: Bool = true
    var launchAtLogin: Bool = false
    var hideDockIcon: Bool = false
    var edgeSnap: Bool = true

    // 핫키 설정
    var hotkeyEnabled: Bool = false
    var hotkeyUseCmd: Bool = true
    var hotkeyUseCtrl: Bool = false
    var hotkeyUseOption: Bool = false

    static let `default` = AppSettings()
}
