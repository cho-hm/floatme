import Foundation

struct FloatingApp: Codable, Identifiable, Equatable, Hashable {
    var id: String { bundleIdentifier }
    let bundleIdentifier: String
    var appName: String
    var order: Int
}
