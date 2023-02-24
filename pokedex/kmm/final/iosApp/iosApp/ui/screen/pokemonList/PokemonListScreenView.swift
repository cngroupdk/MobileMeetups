import SwiftUI

struct PokemonListScreenView: View {

    @StateObject var viewModelWrapper: PokemonListViewModelWrapper

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                ForEach(viewModelWrapper.pokemonList, id: \.id) { pokemon in
                    PokemonItem(
                        pokemon: pokemon,
                        action: {}
                    )
                }
            }
            .padding(.horizontal, 8)
        }
        .background(Theme.colors.background)
    }

}
