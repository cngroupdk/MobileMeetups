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
        // TODO: implement cell
        EmptyView()
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
            .previewLayout(.sizeThatFits)
        }
    }
#endif
