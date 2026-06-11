import AppKit
import Foundation

@MainActor
final class TouchBarController: NSResponder {
    private let batteryViewIdentifier = NSTouchBarItem.Identifier("com.battery-buddy.view")
    private var batteryView: BatteryCharacterView?
    private var currentBatteryLevel: Int = 100

    func updateBatteryLevel(_ level: Int) {
        currentBatteryLevel = level
        batteryView?.batteryLevel = level
        touchBar = nil  // Force Touch Bar refresh
    }
}

extension TouchBarController: NSTouchBarDelegate {
    override var touchBar: NSTouchBar? {
        get {
            let touchBar = NSTouchBar()
            touchBar.delegate = self
            touchBar.defaultItemIdentifiers = [batteryViewIdentifier, .flexibleSpace]
            return touchBar
        }
        set {}
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        if identifier == batteryViewIdentifier {
            let item = NSCustomTouchBarItem(identifier: identifier)
            let view = BatteryCharacterView(frame: NSRect(x: 0, y: 0, width: 120, height: 30))
            view.batteryLevel = currentBatteryLevel
            self.batteryView = view
            item.view = view
            return item
        }
        return nil
    }
}
