import SwiftUI

struct PokemonListCell: View {

    let pokemon: Pokemon

    var body: some View {
        HStack(spacing: 24) {
            pokemon.imageUrl.map {
                AsyncImage(url: $0) { image in
                    image.resizable()
                } placeholder: {
                    Color.clear
                }
                .frame(width: 50, height: 50)
            }
            Text(verbatim: pokemon.name)
        }
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
                )
            )
        }
    }
#endif
