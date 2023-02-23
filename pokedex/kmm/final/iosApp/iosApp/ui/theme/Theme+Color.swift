import Foundation
import SharedResources
import SwiftUI

extension Theme {

    // MARK:  Color
    public struct Color {

        private static let colors = MR.colors()

        public let primary = SwiftUI.Color(
            colors.light_primary.uiColor | colors.dark_primary.uiColor
        )
        public let onPrimary = SwiftUI.Color(
            colors.light_onPrimary.uiColor | colors.dark_onPrimary.uiColor
        )
        public let primaryContainer = SwiftUI.Color(
            colors.light_primaryContainer.uiColor | colors.dark_primaryContainer.uiColor
        )
        public let onPrimaryContainer = SwiftUI.Color(
            colors.light_onPrimaryContainer.uiColor | colors.dark_onPrimaryContainer.uiColor
        )
        public let secondary = SwiftUI.Color(
            colors.light_secondary.uiColor | colors.dark_secondary.uiColor
        )
        public let onSecondary = SwiftUI.Color(
            colors.light_onSecondary.uiColor | colors.dark_onSecondary.uiColor
        )
        public let secondaryContainer = SwiftUI.Color(
            colors.light_secondaryContainer.uiColor | colors.dark_secondaryContainer.uiColor
        )
        public let onSecondaryContainer = SwiftUI.Color(
            colors.light_onSecondaryContainer.uiColor | colors.dark_onSecondaryContainer.uiColor
        )
        public let tertiary = SwiftUI.Color(
            colors.light_tertiary.uiColor | colors.dark_tertiary.uiColor
        )
        public let onTertiary = SwiftUI.Color(
            colors.light_onTertiary.uiColor | colors.dark_onTertiary.uiColor
        )
        public let tertiaryContainer = SwiftUI.Color(
            colors.light_tertiaryContainer.uiColor | colors.dark_tertiaryContainer.uiColor
        )
        public let onTertiaryContainer = SwiftUI.Color(
            colors.light_onTertiaryContainer.uiColor | colors.dark_onTertiaryContainer.uiColor
        )
        public let error = SwiftUI.Color(
            colors.light_error.uiColor | colors.dark_error.uiColor
        )
        public let errorContainer = SwiftUI.Color(
            colors.light_errorContainer.uiColor | colors.dark_errorContainer.uiColor
        )
        public let onError = SwiftUI.Color(
            colors.light_onError.uiColor | colors.dark_onError.uiColor
        )
        public let onErrorContainer = SwiftUI.Color(
            colors.light_onErrorContainer.uiColor | colors.dark_onErrorContainer.uiColor
        )
        public let background = SwiftUI.Color(
            colors.light_background.uiColor | colors.dark_background.uiColor
        )
        public let onBackground = SwiftUI.Color(
            colors.light_onBackground.uiColor | colors.dark_onBackground.uiColor
        )
        public let surface = SwiftUI.Color(
            colors.light_surface.uiColor | colors.dark_surface.uiColor
        )
        public let onSurface = SwiftUI.Color(
            colors.light_onSurface.uiColor | colors.dark_onSurface.uiColor
        )
        public let surfaceVariant = SwiftUI.Color(
            colors.light_surfaceVariant.uiColor | colors.dark_surfaceVariant.uiColor
        )
        public let onSurfaceVariant = SwiftUI.Color(
            colors.light_onSurfaceVariant.uiColor | colors.dark_onSurfaceVariant.uiColor
        )
        public let outline = SwiftUI.Color(
            colors.light_outline.uiColor | colors.dark_outline.uiColor
        )
        public let inverseOnSurface = SwiftUI.Color(
            colors.light_inverseOnSurface.uiColor | colors.dark_inverseOnSurface.uiColor
        )
        public let inverseSurface = SwiftUI.Color(
            colors.light_inverseSurface.uiColor | colors.dark_inverseSurface.uiColor
        )
        public let inversePrimary = SwiftUI.Color(
            colors.light_inversePrimary.uiColor | colors.dark_inversePrimary.uiColor
        )
        public let shadow = SwiftUI.Color(
            colors.light_shadow.uiColor | colors.dark_shadow.uiColor
        )
        public let surfaceTint = SwiftUI.Color(
            colors.light_surfaceTint.uiColor | colors.dark_surfaceTint.uiColor
        )
        public let outlineVariant = SwiftUI.Color(
            colors.light_outlineVariant.uiColor | colors.dark_outlineVariant.uiColor
        )
        public let scrim = SwiftUI.Color(
            colors.light_scrim.uiColor | colors.dark_scrim.uiColor
        )
        public let seed = SwiftUI.Color(colors.seed.uiColor)
    }
}

infix operator |: AdditionPrecedence
extension UIColor {

    /// Easily define two colors for both light and dark mode.
    /// - Parameters:
    ///   - lightMode: The color to use in light mode.
    ///   - darkMode: The color to use in dark mode.
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
    fileprivate static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
