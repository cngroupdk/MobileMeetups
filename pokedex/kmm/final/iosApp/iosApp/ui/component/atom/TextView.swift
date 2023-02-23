import SwiftUI

public enum TextViewContent {
    case verbatim(String)
    case key(LocalizedStringKey)
}

public enum TextViewStyle: CaseIterable {
    case inherit
    case body
    case headline
    case subheadline
    case largeTitle
    case largeSubtitle
    case caption1
    case caption2

    public static let `default`: Self = .body
}

public func TextView(
    verbatim: String,
    _ style: TextViewStyle = .default
) -> Text {
    return TextView(.verbatim(verbatim), style)
}

public func TextView(
    key: LocalizedStringKey,
    _ style: TextViewStyle = .default
) -> Text {
    return TextView(.key(key), style)
}

public func TextView(
    _ content: TextViewContent,
    _ style: TextViewStyle = .default
) -> Text {
    return applyTextViewStyle(
        baseText(content),
        style: style
    )
}

public func TextView(
    _ content: TextViewContent,
    size: CGFloat,
    weight: Font.Weight,
    relativeTo: Font.TextStyle
) -> Text {
    return baseText(content)
        .font(Theme.fonts.main(size, relativeTo: relativeTo))
        .fontWeight(weight)
}

public func baseText(_ content: TextViewContent) -> Text {
    switch content {
    case .verbatim(let verbatim):
        return Text(verbatim: verbatim)
    case .key(let key):
        return Text(key)
    }
}

public func applyTextViewStyle(_ text: Text, style: TextViewStyle) -> Text {
    let customText = text
    switch style {
    case .inherit:
        return customText
    case .body:
        return
            customText
            .font(Theme.fonts.main(15, relativeTo: .body))
    case .headline:
        return
            customText
            .font(Theme.fonts.main(17, relativeTo: .headline))
            .fontWeight(.bold)
    case .subheadline:
        return
            customText
            .font(Theme.fonts.main(15, relativeTo: .subheadline))
            .fontWeight(.regular)
    case .largeTitle:
        return
            customText
            .font(Theme.fonts.main(34, relativeTo: .largeTitle))
            .fontWeight(.bold)
    case .largeSubtitle:
        return
            customText
            .font(Theme.fonts.main(24, relativeTo: .largeTitle))
    case .caption1:
        return
            customText
            .font(Theme.fonts.main(12, relativeTo: .caption))
    case .caption2:
        return
            customText
            .font(Theme.fonts.main(11, relativeTo: .caption2))
    }
}

#if DEBUG
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            VStack(alignment: .leading, spacing: 16) {
                TextView(verbatim: "Hello, .default!")
                TextView(verbatim: "Hello, .largeTitle!", .largeTitle)
                TextView(verbatim: "Hello, .largeSubtitle!", .largeSubtitle)
                TextView(verbatim: "Hello, .body!", .body)
                TextView(verbatim: "Hello, .headline!", .headline)
                TextView(verbatim: "Hello, .subheadline!", .subheadline)
                TextView(verbatim: "Hello, .caption1!", .caption1)
                TextView(verbatim: "Hello, .caption2!", .caption2)
            }
            .multilineTextAlignment(.leading)
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
#endif
