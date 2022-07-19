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
        VStack {
            Button("open detail") {
                print("xxx")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
