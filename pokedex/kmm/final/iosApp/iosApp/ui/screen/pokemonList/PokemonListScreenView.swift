import SwiftUI

struct PokemonListScreenView: View {

    @StateObject var viewModelWrapper: PokemonListViewModelWrapper

    var body: some View {
        List(viewModelWrapper.pokemonList, id: \.id) { pokemon in
            TextView(verbatim: "\(pokemon.id). \(pokemon.name)")
        }
    }

}
