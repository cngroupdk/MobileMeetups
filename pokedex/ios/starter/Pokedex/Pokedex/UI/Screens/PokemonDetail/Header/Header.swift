import SwiftUI

struct Header: View {
    let imageUrl: URL?
    let headerMinHeight: CGFloat

    let imageSize: CGFloat = 280

    var body: some View {
        // TODO: implement content
        EmptyView()
    }
}

#if DEBUG
    struct Header_Previews: PreviewProvider {
        static var previews: some View {
            Header(
                imageUrl: URL(
                    string:
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                ),
                headerMinHeight: 500
            )
            .previewLayout(.sizeThatFits)
        }
    }
#endif
