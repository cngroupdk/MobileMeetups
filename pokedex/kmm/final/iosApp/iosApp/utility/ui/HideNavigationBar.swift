import SwiftUI

public struct HiddenNavigationBar: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

extension View {
    @ViewBuilder
    public func hiddenNavigationBar(
        showBackButton: Bool = false,
        showCloseButton: Bool = false,
        closeDecisionHandler: (() -> ButtonActionPolicy)? = nil
    ) -> some View {
        if showBackButton || showCloseButton {
            ZStack {
                modifier(HiddenNavigationBar())
                VStack {
                    HStack {
                        if showBackButton {
                            CloseButton(variant: .back)
                        }
                        Spacer()
                        if showCloseButton {
                            CloseButton(decisionHandler: closeDecisionHandler)
                                .padding(Theme.space.s2)
                        }
                    }
                    Spacer()
                }
            }
        } else {
            modifier(HiddenNavigationBar())
        }
    }
}
