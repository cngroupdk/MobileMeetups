import SharedKit
import SharedResources
import SwiftUI

struct PokemonListScreenView: View {

    @StateObject var viewModelWrapper: PokemonListViewModelWrapper

    var body: some View {
        NavigationBarWrapper(barTitleView: {
            TextView(verbatim: MR.strings().pokemonList_pokedex.localized(), .largeSubtitle)
                .padding(.horizontal, Theme.space.s3)
                .leadingAligned()
                .eraseToAnyView()
        }) {
            VStack(spacing: Theme.space.s0) {
                SearchBarView(
                    placeholder: MR.strings().pokemonList_lookForPokemon.localized(),
                    text: $viewModelWrapper.searchQuery
                )
                .padding(.vertical, 8)

                pokemonGrid(
                    pokemonList: viewModelWrapper.pokemonList,
                    onSelect: { _ in }
                )
            }
        }
    }

    @ViewBuilder
    private func pokemonGrid(
        pokemonList: [Pokemon],
        onSelect: @escaping (Pokemon) -> Void
    ) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                ForEach(pokemonList, id: \.id) { pokemon in
                    PokemonItem(
                        pokemon: pokemon,
                        action: { onSelect(pokemon) }
                    )
                }
            }
            .padding(.horizontal, 8)
        }
    }

}

#if DEBUG
    struct PokemonListScreenView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonListScreenView(viewModelWrapper: .preview)
        }
    }
#endif
