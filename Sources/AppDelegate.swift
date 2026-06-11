import AppKit
import Foundation
import IOKit.ps

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuBarController: MenuBarController?
    private var touchBarController: TouchBarController?
    private var refreshTimer: Timer?
    private var batteryLevel: Int = 100

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        menuBarController = MenuBarController()
        menuBarController?.setupMenuBar()

        touchBarController = TouchBarController()

        // Initial update
        updateBatteryStatus()

        // Auto-refresh every 5 minutes (300 seconds)
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.updateBatteryStatus()
            }
        }
    }

    private func updateBatteryStatus() {
        batteryLevel = getBatteryLevel()
        menuBarController?.updateBatteryLevel(batteryLevel)
        touchBarController?.updateBatteryLevel(batteryLevel)
    }

    private func getBatteryLevel() -> Int {
        guard let snapshot = IOPSCopyPowerSourcesInfo() as NSArray? else {
            return 100
        }

        for item in snapshot {
            guard let psInfo = item as? NSDictionary else { continue }
            guard let psType = psInfo[kIOPSTypeKey] as? String else { continue }

            if psType == kIOPSInternalBatteryType {
                if let currentCapacity = psInfo[kIOPSCurrentCapacityKey] as? Int,
                   let maxCapacity = psInfo[kIOPSMaxCapacityKey] as? Int,
                   maxCapacity > 0 {
                    return (currentCapacity * 100) / maxCapacity
                }
            }
        }

        return 100
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    func applicationWillTerminate(_ notification: Notification) {
        refreshTimer?.invalidate()
        menuBarController = nil
        touchBarController = nil
    }
}
