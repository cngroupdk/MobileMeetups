import SwiftUI

extension View {
    public func tabViewStyle(
        backgroundColor: Color? = nil,
        backgroundEffect: UIBlurEffect.Style? = nil,
        itemColor: Color? = nil,
        itemFont: UIFont? = nil,
        selectedItemColor: Color? = nil,
        selectedItemFont: UIFont? = nil,
        badgeColor: Color? = nil,
        withScrollEdgeAppearance: Bool = false
    ) -> some View {
        onAppear {
            let itemAppearance = UITabBarItemAppearance()
            if let itemColor = itemColor {
                let uiItemColor = UIColor(itemColor)
                itemAppearance.normal.iconColor = uiItemColor
                itemAppearance.normal.titleTextAttributes = [
                    .foregroundColor: uiItemColor
                ]
            }
            if let itemFont = itemFont {
                itemAppearance.normal.titleTextAttributes[.font] = itemFont
            }

            if let selectedItemColor = selectedItemColor {
                let uiSelectedItemColor = UIColor(selectedItemColor)
                itemAppearance.selected.iconColor = uiSelectedItemColor
                itemAppearance.selected.titleTextAttributes = [
                    .foregroundColor: uiSelectedItemColor
                ]
            }

            if let selectedItemFont = selectedItemFont {
                itemAppearance.selected.titleTextAttributes[.font] =
                    selectedItemFont
            }

            if let badgeColor = badgeColor {
                let uiBadgeColor = UIColor(badgeColor)
                itemAppearance.normal.badgeBackgroundColor = uiBadgeColor
                itemAppearance.selected.badgeBackgroundColor = uiBadgeColor
            }

            let appearance = UITabBarAppearance()
            if let backgroundColor = backgroundColor {
                let uiBackgroundColor = UIColor(backgroundColor)
                appearance.backgroundColor = uiBackgroundColor
            }
            if let backgroundEffect = backgroundEffect {
                appearance.backgroundEffect = UIBlurEffect(
                    style: backgroundEffect
                )
            }

            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
