import SwiftUI

public struct NavigationBar: View {

    public static let height: CGFloat = Theme.space.s8

    private let topInset: CGFloat
    private let titleViewBuilder: (() -> AnyView)?

    public init(titleView: (() -> AnyView)? = nil) {
        self.topInset = UIApplication.safeAreaInsets.top
        self.titleViewBuilder = titleView
    }

    public var body: some View {
        ZStack(alignment: .center) {
            Theme.colors.primary
                .background(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.top)

            if let titleViewBuilder = titleViewBuilder {
                titleViewBuilder()
                    .foregroundColor(Theme.colors.onPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, Theme.space.s1)
            }
        }
        .frame(height: Self.height)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#if DEBUG
    struct NavigationBar_Previews: PreviewProvider {
        static var previews: some View {
            NavigationBar(
                titleView: { Text("Pokedex").eraseToAnyView() }
            )
        }
    }
#endif
