import SharedResources
import SwiftUI

extension ResourcesColorResource {
    var uiColor: UIColor {
        let graphicsColor = self.toColor()
        return UIColor(
            red: Double(graphicsColor.red) / 255.0,
            green: Double(graphicsColor.green) / 255.0,
            blue: Double(graphicsColor.blue) / 255.0,
            alpha: Double(graphicsColor.alpha) / 255.0
        )
    }

    var color: SwiftUI.Color {
        let graphicsColor = self.toColor()
        return Color(
            red: Double(graphicsColor.red) / 255.0,
            green: Double(graphicsColor.green) / 255.0,
            blue: Double(graphicsColor.blue) / 255.0
        )
        .opacity(Double(graphicsColor.alpha) / 255.0)
    }
}
