import SwiftUI

struct PokemonDetailScreenView<
    ViewModel: PokemonDetailViewModelProtocol & PokemonDetailFlowStateProtocol
>: View {

    @StateObject var viewModel: ViewModel

    let imageSize: CGFloat = 280

    var body: some View {
        PokemonDetailFlowCoordinator(state: viewModel, content: content)
    }

    @ViewBuilder
    private func content() -> some View {
        LoaderView(
            requestState: viewModel.pokemonRequest,
            onNotAsked: { viewModel.loadDetailIfNeeded() }
        ) { pokemon in
            GeometryReader { geometry in
                VStack {
                    Header(
                        imageUrl: pokemon.imageUrl,
                        headerMinHeight: geometry.size.height / 3
                    )

                    Title(
                        id: pokemon.id,
                        name: pokemon.name,
                        type: pokemon.detail?.type
                    )

                    StatInfo(
                        label: "Base Experience",
                        value: pokemon.detail?.baseExperience
                    )

                    StatInfo(
                        label: "Weight",
                        value: pokemon.detail?.weight
                    )

                    StatInfo(
                        label: "Height",
                        value: pokemon.detail?.height
                    )

                    StatInfo(
                        label: "HP",
                        value: pokemon.detail?.hp
                    )

                    StatInfo(
                        label: "Attack",
                        value: pokemon.detail?.attack
                    )
                }

                Spacer()
            }
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
