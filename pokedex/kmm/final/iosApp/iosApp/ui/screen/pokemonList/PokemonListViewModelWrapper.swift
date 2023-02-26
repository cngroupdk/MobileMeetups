import Combine
import Foundation
import KMPNativeCoroutinesCombine
import SharedKit

final class PokemonListViewModelWrapper: BaseViewModelWrapper<PokemonListViewModel>,
    PokemonListFlowStateProtocol
{

    @Published private(set) var pokemonList: [Pokemon] = []
    @Published var searchQuery: String = ""

    private var cancellables: Set<AnyCancellable> = .init()

    convenience init() {
        self.init(parameters: nil)
    }

    required init(parameters: [AnyObject]?) {
        super.init(parameters: parameters)
        mapCoroutines()
        setupSubscriptions()
    }

    private func mapCoroutines() {
        createPublisher(for: viewModel.pokemonListFlowNative)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$pokemonList)
    }

    private func setupSubscriptions() {
        $searchQuery
            .dropFirst()
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.viewModel.searchPokemon(term: $0)
            })
            .store(in: &cancellables)
    }

    // MARK: - Flow state
    @Published var route: PokemonListRoute?

    func openPokemonDetail(for pokemon: Pokemon) {
        guard !ProcessInfo.isSwiftUIPreview else { return }
        self.route = .pokemonDetail(pokemon)
    }

}

#if DEBUG
    extension PokemonListViewModelWrapper {
        static var preview: Self {
            .preview(vm: PokemonListViewModel(repository: MockPokedexRepository()))
        }
    }
#endif
