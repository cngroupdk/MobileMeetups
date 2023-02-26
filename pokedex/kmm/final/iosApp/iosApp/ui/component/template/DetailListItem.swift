import SwiftUI

struct DetailListItem: View {

    let title: String
    let value: String?

    var body: some View {
        HStack {
            TextView(verbatim: title)
                .foregroundColor(Theme.colors.onBackground.opacity(0.6))
            Spacer()
            if let value = value {
                TextView(verbatim: value, .body)
                    .fontWeight(.bold)
            }
        }
        .padding(Theme.space.s2)
    }

}

#if DEBUG
    struct DetailListItem_Previews: PreviewProvider {
        static var previews: some View {
            DetailListItem(title: "Base Experience", value: "64")
                .previewLayout(.sizeThatFits)
        }
    }
#endif
