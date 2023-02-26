import SharedResources
import SwiftUI

struct PokemonDetailScreenView: View {

    @StateObject var viewModelWrapper: PokemonDetailViewModelWrapper

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Group {
                if let pokemon = viewModelWrapper.pokemon,
                    let imageUrlStr = pokemon.imageUrl,
                    let imageUrl = URL(string: imageUrlStr)
                {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                }
            }
            .frame(height: 300)
            .padding(Theme.space.s4)
            .background(Theme.colors.secondary)

            VStack(spacing: 0) {
                if let pokemon = viewModelWrapper.pokemon {
                    TextView(verbatim: "#\(pokemon.id) \(pokemon.name)", .largeSubtitle)
                        .fontWeight(.bold)

                    PokemonTypes(types: viewModelWrapper.pokemon?.types ?? [])
                        .padding(Theme.space.s2)

                    DetailListItem(
                        title: MR.strings().pokemonDetail_baseExperience.localized(),
                        value: "\(pokemon.baseExperience)"
                    )
                    DetailListItem(
                        title: MR.strings().pokemonDetail_weight.localized(),
                        value: "\(pokemon.weight)"
                    )
                    DetailListItem(
                        title: MR.strings().pokemonDetail_height.localized(),
                        value: "\(pokemon.height)"
                    )

                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
            .padding(Theme.space.s5)
        }

    }
}

#if DEBUG
    struct PokemonDetailScreenView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonDetailScreenView(viewModelWrapper: .preview)
        }
    }
#endif
