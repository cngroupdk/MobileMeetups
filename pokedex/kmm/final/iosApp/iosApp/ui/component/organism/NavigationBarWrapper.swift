import SwiftUI

public struct NavigationBarWrapper<Content: View>: View {

    private let barTitleView: (() -> AnyView)?
    private let content: () -> Content

    public init(
        barTitleView: (() -> AnyView)? = nil,
        content: @escaping () -> Content
    ) {
        self.barTitleView = barTitleView
        self.content = content
    }

    public var body: some View {
        content()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.colors.background)
            .hiddenNavigationBar()
            .clearScrollContentBackground()
            .safeAreaInset(
                edge: .top,
                spacing: Theme.space.s0,
                content: {
                    Color.clear.frame(height: NavigationBar.height)
                }
            )
            .overlay(
                NavigationBar(titleView: barTitleView)
            )
    }
}

#if DEBUG
    struct NavigationBarWrapper_Previews: PreviewProvider {
        static var previews: some View {
            NavigationBarWrapper.init {
                Theme.colors.background
            }
        }
    }
#endif
