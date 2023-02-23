import SwiftUI

public struct SecondaryButton<Label: View>: View {
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
                .padding(.horizontal, Theme.space.s5)
                .padding(.vertical, Theme.space.s3)
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

private struct SecondaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(
                configuration.isPressed ? Theme.colors.primary.opacity(0.65) : Theme.colors.primary
            )
            .background(
                configuration.isPressed
                    ? Theme.colors.background.opacity(0.65) : Theme.colors.background
            )
            .cornerRadius(Theme.radii.r4)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radii.r4)
                    .stroke(Theme.colors.onBackground, lineWidth: 1)
            )
    }

}

#if DEBUG
    struct SecondaryButton_Previews: PreviewProvider {
        static var previews: some View {
            SecondaryButton(action: {}) {
                Text("press me")
            }
            .previewLayout(.sizeThatFits)
        }
    }
#endif
