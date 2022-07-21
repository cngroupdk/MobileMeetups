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
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    ForEach(viewModel.filteredPokemons, id: \.self) { pokemon in
                        PokemonListCell(
                            pokemon: pokemon,
                            action: {
                                if let $pokemon = $viewModel.pokemons.first(where: {
                                    $0.wrappedValue == pokemon
                                }) {
                                    viewModel.openPokemonDetail(for: $pokemon)
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, 8)
            }
            .overlay {
                if pokemons.isEmpty {
                    Text("No pokemon available at the moment")
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Look for pokémon")
        .navigationTitle("Pokémon")
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
