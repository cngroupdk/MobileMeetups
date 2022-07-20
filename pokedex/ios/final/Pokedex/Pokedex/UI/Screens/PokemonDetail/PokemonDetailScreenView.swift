import SwiftUI

struct PokemonDetailScreenView<
    ViewModel: PokemonDetailViewModelProtocol & PokemonDetailFlowStateProtocol
>: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
        PokemonDetailFlowCoordinator(state: viewModel, content: content)
    }

    @ViewBuilder
    private func content() -> some View {
        LoaderView(
            requestState: viewModel.request,
            onNotAsked: { viewModel.loadDetailIfNeeded() }
        ) { pokemon in
            VStack {
                pokemon.imageUrl.map {
                    AsyncImage(url: $0) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                    .frame(width: 150, height: 150)
                }
                Text(pokemon.name)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#if DEBUG
    struct PokemonDetailScreenView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonDetailScreenView<PokemonDetailViewModel>(
                viewModel: .preview
            )
        }
    }
#endif
