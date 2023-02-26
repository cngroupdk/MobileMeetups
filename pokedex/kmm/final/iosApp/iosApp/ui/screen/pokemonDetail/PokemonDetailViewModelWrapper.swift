import Foundation
import KMPNativeCoroutinesCombine
import SharedKit

final class PokemonDetailViewModelWrapper: BaseViewModelWrapper<PokemonDetailViewModel> {

    @Published private(set) var pokemon: PokemonDetail?

    convenience init(pokemonId: String) {
        self.init(parameters: [NSString(string: pokemonId)])
    }

    required init(parameters: [AnyObject]?) {
        super.init(parameters: parameters)
        mapCoroutines()
    }

    private func mapCoroutines() {
        createPublisher(for: viewModel.pokemonDetailFlowNative)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$pokemon)
    }

}

#if DEBUG
    extension PokemonDetailViewModelWrapper {
        static var preview: Self {
            .preview(
                vm: PokemonDetailViewModel(
                    repository: MockPokedexRepository(),
                    pokemonId: "1"
                )
            )
        }
    }
#endif
