import Foundation
import SwiftUI

struct PokemonListScreenView<
    ViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol
>: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        PokemonListFlowCoordinator(state: viewModel, content: content)
    }

    @ViewBuilder
    private func content() -> some View {
        LoaderView(
            requestState: viewModel.request,
            onNotAsked: { viewModel.loadData() }
        ) { pokemons in
            List(pokemons, id: \.self) { pokemon in
                Button(action: {
                    if let $pokemon = $viewModel.pokemons.first(where: {
                        $0.wrappedValue == pokemon
                    }) {
                        pokemon.id % 2 == 0
                            ? viewModel.openPokemonDetailSheet(for: $pokemon)
                            : viewModel.openPokemonDetail(for: $pokemon)
                    }
                }) {
                    PokemonListCell(pokemon: pokemon)
                }
            }
            .overlay {
                if pokemons.isEmpty {
                    Text("No pokemon available at the moment")
                }
            }
        }
        .navigationTitle("Pokemons")
    }

}

#if DEBUG
    struct PokemonListScreenView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonListScreenView<PokemonListViewModel>(
                viewModel: .preview
            )
        }
    }
#endif
