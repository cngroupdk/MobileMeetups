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
        // TODO: implement content
        EmptyView()
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
