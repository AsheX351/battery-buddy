import AppKit
import Foundation

final class BatteryCharacterView: NSView {
    var batteryLevel: Int = 100 {
        didSet {
            needsDisplay = true
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Dark background
        NSColor(white: 0.15, alpha: 1).setFill()
        bounds.fill()

        // Draw character
        drawCharacter()
    }

    private func drawCharacter() {
        let centerX = bounds.midX - 20
        let centerY = bounds.midY

        // Head
        drawHead(centerX: centerX, centerY: centerY)

        // Body
        drawBody(centerX: centerX, centerY: centerY - 15)

        // Arms
        drawArms(centerX: centerX, centerY: centerY - 12)

        // Legs
        drawLegs(centerX: centerX, centerY: centerY - 25)

        // Battery indicator on side
        drawBatteryIndicator(centerX: centerX + 35, centerY: centerY)
    }

    private func drawHead(centerX: CGFloat, centerY: CGFloat) {
        let headRadius: CGFloat = 8
        let headPath = NSBezierPath(ovalIn: NSRect(
            x: centerX - headRadius,
            y: centerY + 5,
            width: headRadius * 2,
            height: headRadius * 2
        ))
        getCharacterColor().setFill()
        headPath.fill()

        // Eyes
        let eyeRadius: CGFloat = 1.5
        let leftEyePath = NSBezierPath(ovalIn: NSRect(
            x: centerX - 4,
            y: centerY + 9,
            width: eyeRadius * 2,
            height: eyeRadius * 2
        ))
        NSColor.white.setFill()
        leftEyePath.fill()

        let rightEyePath = NSBezierPath(ovalIn: NSRect(
            x: centerX + 2,
            y: centerY + 9,
            width: eyeRadius * 2,
            height: eyeRadius * 2
        ))
        rightEyePath.fill()

        // Pupils
        let pupilRadius: CGFloat = 0.8
        let pupilX = centerX - 3 + CGFloat(batteryLevel) / 100 * 3
        let leftPupilPath = NSBezierPath(ovalIn: NSRect(
            x: pupilX,
            y: centerY + 9.3,
            width: pupilRadius * 2,
            height: pupilRadius * 2
        ))
        NSColor.black.setFill()
        leftPupilPath.fill()

        let rightPupilPath = NSBezierPath(ovalIn: NSRect(
            x: pupilX + 6,
            y: centerY + 9.3,
            width: pupilRadius * 2,
            height: pupilRadius * 2
        ))
        rightPupilPath.fill()

        // Smile
        let smilePath = NSBezierPath()
        smilePath.lineWidth = 0.8
        smilePath.move(to: NSPoint(x: centerX - 2, y: centerY + 4))
        smilePath.curve(to: NSPoint(x: centerX + 2, y: centerY + 4),
                       controlPoint1: NSPoint(x: centerX - 1, y: centerY + 2),
                       controlPoint2: NSPoint(x: centerX + 1, y: centerY + 2))
        getCharacterColor().setStroke()
        smilePath.stroke()
    }

    private func drawBody(centerX: CGFloat, centerY: CGFloat) {
        let bodyPath = NSBezierPath(rect: NSRect(
            x: centerX - 4,
            y: centerY - 8,
            width: 8,
            height: 10
        ))
        getCharacterColor().setFill()
        bodyPath.fill()
    }

    private func drawArms(centerX: CGFloat, centerY: CGFloat) {
        // Left arm
        let leftArmPath = NSBezierPath()
        leftArmPath.lineWidth = 1.2
        leftArmPath.move(to: NSPoint(x: centerX - 4.5, y: centerY))
        let armOffset = CGFloat(batteryLevel) / 100 * 2 - 1
        leftArmPath.line(to: NSPoint(x: centerX - 8, y: centerY - armOffset))
        getCharacterColor().setStroke()
        leftArmPath.stroke()

        // Right arm
        let rightArmPath = NSBezierPath()
        rightArmPath.lineWidth = 1.2
        rightArmPath.move(to: NSPoint(x: centerX + 4.5, y: centerY))
        rightArmPath.line(to: NSPoint(x: centerX + 8, y: centerY - armOffset))
        rightArmPath.stroke()
    }

    private func drawLegs(centerX: CGFloat, centerY: CGFloat) {
        // Left leg
        let leftLegPath = NSBezierPath()
        leftLegPath.lineWidth = 1
        leftLegPath.move(to: NSPoint(x: centerX - 2, y: centerY))
        leftLegPath.line(to: NSPoint(x: centerX - 3, y: centerY - 5))
        getCharacterColor().setStroke()
        leftLegPath.stroke()

        // Right leg
        let rightLegPath = NSBezierPath()
        rightLegPath.lineWidth = 1
        rightLegPath.move(to: NSPoint(x: centerX + 2, y: centerY))
        rightLegPath.line(to: NSPoint(x: centerX + 3, y: centerY - 5))
        rightLegPath.stroke()
    }

    private func drawBatteryIndicator(centerX: CGFloat, centerY: CGFloat) {
        let barHeight: CGFloat = 15
        let barWidth: CGFloat = 8

        // Battery body
        let batteryPath = NSBezierPath(roundedRect: NSRect(
            x: centerX - barWidth / 2,
            y: centerY - barHeight / 2,
            width: barWidth,
            height: barHeight
        ), xRadius: 1, yRadius: 1)
        NSColor(white: 0.3, alpha: 1).setStroke()
        batteryPath.lineWidth = 0.8
        batteryPath.stroke()

        // Battery terminal
        let terminalPath = NSBezierPath(rect: NSRect(
            x: centerX - 2,
            y: centerY + barHeight / 2 - 1,
            width: 4,
            height: 1
        ))
        terminalPath.fill()

        // Battery level fill
        let fillHeight = barHeight * CGFloat(batteryLevel) / 100
        let fillPath = NSBezierPath(rect: NSRect(
            x: centerX - barWidth / 2 + 0.5,
            y: centerY - barHeight / 2 + (barHeight - fillHeight) + 0.5,
            width: barWidth - 1,
            height: fillHeight - 1
        ))
        getCharacterColor().setFill()
        fillPath.fill()

        // Percentage text
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 6, weight: .bold),
            .foregroundColor: NSColor.white
        ]
        let percentText = "\(batteryLevel)%"
        let textSize = (percentText as NSString).size(withAttributes: textAttributes)
        let textX = centerX - textSize.width / 2
        let textY = centerY - barHeight / 2 - 6
        (percentText as NSString).draw(at: NSPoint(x: textX, y: textY), withAttributes: textAttributes)
    }

    private func getCharacterColor() -> NSColor {
        switch batteryLevel {
        case 75...100:
            return NSColor(red: 0.2, green: 0.9, blue: 0.3, alpha: 1)  // Bright green
        case 50..<75:
            return NSColor(red: 0.6, green: 0.8, blue: 0.2, alpha: 1)  // Yellow-green
        case 25..<50:
            return NSColor(red: 1, green: 0.7, blue: 0.2, alpha: 1)    // Orange
        default:
            return NSColor(red: 1, green: 0.3, blue: 0.3, alpha: 1)    // Red
        }
    }
}
