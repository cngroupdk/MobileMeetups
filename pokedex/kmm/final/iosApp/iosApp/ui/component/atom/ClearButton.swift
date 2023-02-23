import Foundation
import SwiftUI

public struct ClearButton<Content: View>: View {
    private let action: () -> Void
    @ViewBuilder private let label: () -> Content

    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Content
    ) {
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(
            action: self.action,
            label: self.label
        )
        .buttonStyle(.plain)
        .background(.clear)
    }
}

#if DEBUG
    struct ClearButtonView_Previews: PreviewProvider {
        static var previews: some View {
            ClearButton(action: {}) {
                Text(verbatim: "Click me!")
            }
        }
    }
#endif
