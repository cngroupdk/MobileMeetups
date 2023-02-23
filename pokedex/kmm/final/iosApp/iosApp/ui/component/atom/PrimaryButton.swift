import SwiftUI

public struct PrimaryButton<Label: View>: View {
    private let action: () -> Void
    private let labelBuilder: () -> Label

    public init(
        action: @escaping () -> Void,
        label: @escaping () -> Label
    ) {
        self.action = action
        self.labelBuilder = label
    }

    public var body: some View {
        Button(action: action) {
            labelBuilder()
                .padding(.horizontal, Theme.space.s4)
                .padding(.vertical, Theme.space.s2)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

private struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Theme.colors.onPrimary)
            .background(
                configuration.isPressed ? Theme.colors.primary.opacity(0.65) : Theme.colors.primary
            )
            .cornerRadius(Theme.radii.r4)
    }

}

#if DEBUG
    struct PrimaryButton_Previews: PreviewProvider {
        static var previews: some View {
            PrimaryButton(action: {}) {
                Text("press me")
            }
            .previewLayout(.sizeThatFits)
        }
    }
#endif
