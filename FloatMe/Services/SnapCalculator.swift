import AppKit

struct SnapCalculator {
    static let threshold: CGFloat = 20

    static func snap(_ origin: CGPoint, barSize: CGSize, on screen: NSScreen?) -> CGPoint {
        guard let frame = screen?.visibleFrame else { return origin }
        var x = origin.x
        var y = origin.y

        if abs(x - frame.minX) < threshold { x = frame.minX }
        if abs((x + barSize.width) - frame.maxX) < threshold { x = frame.maxX - barSize.width }
        if abs(y - frame.minY) < threshold { y = frame.minY }
        if abs((y + barSize.height) - frame.maxY) < threshold { y = frame.maxY - barSize.height }

        x = max(frame.minX - barSize.width / 2, min(x, frame.maxX - barSize.width / 2))
        y = max(frame.minY - barSize.height / 2, min(y, frame.maxY - barSize.height / 2))

        return CGPoint(x: x, y: y)
    }
}
