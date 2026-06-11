import AppKit
import Foundation

@MainActor
final class MenuBarController {
    private var statusItem: NSStatusItem?
    private var batteryLevel: Int = 100

    func setupMenuBar() {
        let statusBar = NSStatusBar.system
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)

        guard let button = statusItem?.button else { return }
        button.title = "🔋"
        button.toolTip = "Battery Buddy"

        let menu = NSMenu()

        let batteryItem = NSMenuItem(title: "Battery: 100%", action: nil, keyEquivalent: "")
        batteryItem.isEnabled = false
        menu.addItem(batteryItem)

        menu.addItem(NSMenuItem.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem?.menu = menu
    }

    func updateBatteryLevel(_ level: Int) {
        batteryLevel = level
        if let button = statusItem?.button {
            button.title = "🔋 \(level)%"
        }
        if let menu = statusItem?.menu, let item = menu.item(at: 0) {
            item.title = "Battery: \(level)%"
        }
    }

    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
