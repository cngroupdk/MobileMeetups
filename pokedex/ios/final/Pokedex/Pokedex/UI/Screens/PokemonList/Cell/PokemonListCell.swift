import SwiftUI

struct PokemonListCell: View {

    let pokemon: Pokemon
    let action: () -> Void

    private var cardColor: Color? {
        guard let type = pokemon.detail?.type,
            let colorHex = Constant.pokemonTypeColors[type]
        else { return nil }
        return Color(hex: colorHex).opacity(0.4)
    }

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomTrailing) {
                pokemon.imageUrl.map {
                    AsyncImage(url: $0) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                    .frame(width: 80, height: 80)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(verbatim: pokemon.name.capitalized)
                        .font(.headline)
                        .fontWeight(.bold)

                    Group {
                        Text(verbatim: "\(pokemon.id)")
                            .font(.caption2)

                        if let type = pokemon.detail?.type {
                            Text(verbatim: type)
                                .font(.caption2)
                        }
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(cardColor ?? Color.gray.opacity(0.1))
                    .clipShape(Capsule())

                    Spacer()
                }
                .foregroundColor(Color.primary)
                .leadingAligned()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(6)
            .ifLet(
                cardColor,
                content: { view, color in
                    view.background(color.background(.ultraThickMaterial))
                },
                else: { $0.background(.ultraThinMaterial) }
            )
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
    struct PokemonListCell_Previews: PreviewProvider {
        static var previews: some View {
            PokemonListCell(
                pokemon: .init(
                    id: 1,
                    name: "bulbasaur",
                    imageUrl: URL(
                        string:
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                    )
                ),
                action: {}
            )
            .frame(width: 200, height: 120)
            .previewLayout(.sizeThatFits)
        }
    }
#endif
