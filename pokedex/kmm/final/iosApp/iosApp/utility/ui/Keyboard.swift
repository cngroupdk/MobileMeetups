import SwiftUI
import UIKit

public func dismissKeyboard() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}

private struct ScrollDismissesKeyboardModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollDismissesKeyboard(.interactively)
        } else {
            content
        }
    }
}

extension View {
    @ViewBuilder
    public func scrollDismissesKeyboard() -> some View {
        modifier(ScrollDismissesKeyboardModifier())
    }
}
