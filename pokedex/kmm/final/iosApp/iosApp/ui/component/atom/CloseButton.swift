import SwiftUI

// MARK: - ButtonActionPolicy
public enum ButtonActionPolicy {
    case allow
    case cancel
}

// MARK: - CloseButton
public struct CloseButton: View {

    public enum Variant {
        case xmark
        case back

        var systemIconName: String {
            switch self {
            case .back: return "arrow.left"
            case .xmark: return "xmark"
            }
        }
    }

    @Environment(\.presentationMode) private var presentationMode

    private let decisionHandler: (() -> ButtonActionPolicy)?
    private let variant: Variant
    private var onTap: (() -> Void)?

    private var action: () -> Void {
        if let action = onTap {
            return action
        } else {
            return {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }

    public init(
        variant: Variant = .xmark,
        decisionHandler: (() -> ButtonActionPolicy)? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.variant = variant
        self.decisionHandler = decisionHandler
        self.onTap = onTap
    }

    public init(onTap: @escaping () -> Void) {
        self.init(decisionHandler: nil, onTap: onTap)
    }

    public var body: some View {
        IconButton(
            icon: .systemName(variant.systemIconName),
            onTap: {
                if let decisionHandler = self.decisionHandler {
                    if decisionHandler() == .allow {
                        action()
                    }
                } else {
                    action()
                }
            }
        )
    }
}

#if DEBUG
    struct CloseButton_Previews: PreviewProvider {
        static var previews: some View {
            CloseButton()
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
#endif
