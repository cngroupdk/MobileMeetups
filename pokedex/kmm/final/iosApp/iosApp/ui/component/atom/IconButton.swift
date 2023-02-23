import SwiftUI

public struct IconButton: View {

    public enum IconVariant {
        case systemName(String)
    }

    private var icon: IconVariant
    private var onTap: (() -> Void)

    public init(icon: IconVariant, onTap: @escaping (() -> Void)) {
        self.icon = icon
        self.onTap = onTap
    }

    private var image: Image {
        switch icon {
        case .systemName(let iconName):
            return Image(systemName: iconName)
        }
    }

    public var body: some View {
        ClearButton(action: onTap) {
            image
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
        }
    }
}

#if DEBUG
    struct IconButton_Previews: PreviewProvider {
        static var previews: some View {
            IconButton(icon: .systemName("chevron.backward"), onTap: {})
                .previewLayout(.sizeThatFits)
        }
    }
#endif
