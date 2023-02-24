import SwiftUI

public struct SearchBarView: View {
    let placeholder: String
    let isAutocorrectionDisabled: Bool

    @Binding public private(set) var text: String

    @State private var isEditing: Bool = false

    public init(
        placeholder: String,
        isAutocorrectionDisabled: Bool = true,
        text: Binding<String> = .constant("")
    ) {
        self.placeholder = placeholder
        self.isAutocorrectionDisabled = isAutocorrectionDisabled
        self._text = text
    }

    public var body: some View {
        TextField(
            "",
            text: $text,
            onEditingChanged: { editing in
                guard editing else { return }
                self.isEditing = editing
            }
        )
        .placeholder(placeholder, when: text.isEmpty)
        .frame(height: Theme.space.s7)
        .padding(.leading, Theme.space.s3)
        .padding(.trailing, Theme.space.s5 + Theme.space.s2)
        .foregroundColor(Theme.colors.onSurfaceVariant)
        .accentColor(Theme.colors.onSurfaceVariant)
        .background(Theme.colors.surfaceVariant)
        .cornerRadius(Theme.radii.r3)
        .overlay(
            HStack {
                if isEditing && !self.text.isEmpty {
                    Spacer()
                    ClearButton(action: { self.text = "" }) {
                        Image(systemName: "xmark")
                            .padding(.trailing, Theme.space.s2)
                            .frame(width: Theme.space.s5, height: Theme.space.s5)
                    }
                }
            }
            .foregroundColor(Theme.colors.onSurfaceVariant)
        )
        .padding(.leading, Theme.space.s3)
        .padding(.trailing, Theme.space.s2)
        .disableAutocorrection(self.isAutocorrectionDisabled)
        .submitLabel(.search)
        .onSubmit(dismissKeyboard)
        .onDisappear(perform: dismissKeyboard)
    }
}

extension View {
    fileprivate func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading
    ) -> some View {

        placeholder(when: shouldShow, alignment: alignment) {
            Text(text).foregroundColor(Theme.colors.onSurfaceVariant.opacity(0.75))
        }
    }
}

#if DEBUG
    struct SearchBar_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                SearchBarView(
                    placeholder: "Search...",
                    text: .constant("Something long long longdsadsdassadsddas ")
                )
            }
        }
    }
#endif
