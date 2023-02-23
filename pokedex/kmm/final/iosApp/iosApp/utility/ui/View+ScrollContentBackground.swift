import SwiftUI

struct ScrollContentBackgroundModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

extension View {
    @ViewBuilder
    public func clearScrollContentBackground() -> some View {
        modifier(ScrollContentBackgroundModifier())
    }
}
