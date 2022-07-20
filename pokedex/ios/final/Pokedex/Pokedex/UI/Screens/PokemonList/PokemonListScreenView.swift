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
            List(Array(pokemons.enumerated()), id: \.offset) { offset, pokemon in
                Button(action: {
                    offset % 2 == 0
                        ? viewModel.openPokemonDetailSheet(for: pokemon)
                        : viewModel.openPokemonDetail(for: pokemon)
                }) {
                    HStack(spacing: 24) {
                        pokemon.image.map {
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
