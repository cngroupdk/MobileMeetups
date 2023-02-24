import SharedKit
import SwiftUI

struct PokemonItem: View {
    let pokemon: Pokemon
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomTrailing) {
                if let imageUrlStr = pokemon.imageUrl,
                    let imageUrl = URL(string: imageUrlStr)
                {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                    .frame(width: 80, height: 80)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(verbatim: pokemon.name)
                        .font(.headline)
                        .fontWeight(.bold)

                    Group {
                        Text(verbatim: "#\(pokemon.id)")
                            .font(.caption2)
                    }
                    .padding(2)
                    .background(Theme.colors.primary.opacity(0.2))
                    .clipShape(
                        RoundedCornersShape(
                            radius: Theme.radii.r2,
                            corners: [.allCorners]
                        )
                    )

                    Spacer()
                }
                .foregroundColor(Theme.colors.onBackground)
                .leadingAligned()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(Theme.space.s2)
            .background(Theme.colors.primary.opacity(0.1).background(.ultraThickMaterial))
            .clipShape(
                RoundedCornersShape(
                    radius: 12,
                    corners: [.allCorners]
                )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .background(.clear)
    }

}

#if DEBUG
    struct PokemonItem_Previews: PreviewProvider {
        static var previews: some View {
            PokemonItem(
                pokemon: .init(
                    id: 1,
                    name: "bulbasaur",
                    imageUrl:
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                ),
                action: {}
            )
            .frame(width: 200, height: 120)
            .previewLayout(.sizeThatFits)
        }
    }
#endif
