import SwiftUI

struct Header: View {
    let imageUrl: URL?
    let headerMinHeight: CGFloat

    let imageSize: CGFloat = 280

    var body: some View {
        VStack {
            imageUrl.map {
                AsyncImage(url: $0) { image in
                    image
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                } placeholder: {
                    Color.clear
                }
            }
        }
        .frame(minHeight: headerMinHeight)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(
                        color: Color(
                            hue: 0.5228168533509037,
                            saturation: 0.25107068900602414,
                            brightness: 1.0,
                            opacity: 1.0
                        ),
                        location: 0.0
                    ),
                    Gradient.Stop(
                        color: Color(
                            hue: 0.6437547063253013,
                            saturation: 0.40718244070030124,
                            brightness: 0.8,
                            opacity: 1.0
                        ),
                        location: 0.9997521033653847
                    ),
                ]),
                startPoint: UnitPoint.topLeading,
                endPoint: UnitPoint.bottomTrailing
            )
        )
    }
}

#if DEBUG
    struct Header_Previews: PreviewProvider {
        static var previews: some View {
            Header(imageUrl: URL(string: ""), headerMinHeight: 500)
                .previewLayout(.sizeThatFits)
        }
    }
#endif
