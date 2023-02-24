import SharedResources
import SwiftUI

struct PokemonListScreenView: View {

    @StateObject var viewModelWrapper: PokemonListViewModelWrapper

    var body: some View {
        NavigationBarWrapper(barTitleView: {
            TextView(verbatim: MR.strings().pokemonList_pokedex.localized(), .largeTitle)
                .padding(.horizontal, Theme.space.s3)
                .leadingAligned()
                .eraseToAnyView()
        }) {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    ForEach(viewModelWrapper.pokemonList, id: \.id) { pokemon in
                        PokemonItem(
                            pokemon: pokemon,
                            action: {}
                        )
                    }
                }
                .padding(8)
            }
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
