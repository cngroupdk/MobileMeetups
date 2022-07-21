import SwiftUI

struct Title: View {
    let id: Int
    let name: String
    let type: String?

    var body: some View {
        VStack {
            Text("#\(id) \(name.capitalized)")
                .font(.title)
                .bold()
                .tracking(2)
                .padding(.top)
                .opacity(0.7)

            Badge(type: type)
        }
        .padding(.bottom)
    }
}

#if DEBUG
    struct Title_Previews: PreviewProvider {
        static var previews: some View {
            Title(id: 1, name: "bulbasaur", type: "grass")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
#endif
