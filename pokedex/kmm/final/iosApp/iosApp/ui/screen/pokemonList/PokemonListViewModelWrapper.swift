import Combine
import Foundation
import KMPNativeCoroutinesCombine
import SharedKit

final class PokemonListViewModelWrapper: BaseViewModelWrapper<PokemonListViewModel> {

    @Published var pokemonList: [Pokemon] = []

    private var cancellables: Set<AnyCancellable> = .init()

    convenience init() {
        self.init(parameters: nil)
    }

    required init(parameters: [AnyObject]?) {
        super.init(parameters: parameters)
        mapCoroutines()
    }

    private func mapCoroutines() {
        createPublisher(for: viewModel.pokemonListFlowNative)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$pokemonList)
    }

}

#if DEBUG
    extension PokemonListViewModelWrapper {
        static var preview: Self {
            .preview(vm: PokemonListViewModel(repository: MockPokedexRepository()))
        }
    }
#endif
