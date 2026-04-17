import AppKit
import Observation

@MainActor
@Observable
final class EditModeManager {
    var isActive = false
    var showSelector = false

    func exit() {
        isActive = false
        showSelector = false
    }

    func setupExitMonitors(panel: NSPanel) {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 && self?.isActive == true {
                self?.exit()
                return nil
            }
            return event
        }

        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] _ in
            guard self?.isActive == true else { return }
            if !panel.frame.contains(NSEvent.mouseLocation) {
                DispatchQueue.main.async { self?.exit() }
            }
        }
    }
}
