import Combine
import Foundation

protocol PokemonListViewModelProtocol: ObservableObject {
    typealias ModelType = Pokemon

    var request: RequestState<[ModelType]> { get }

    func loadData()
}

final class PokemonListViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol {

    private let repository: RepositoryServiceProtocol
    private var loadingCancellables: Set<AnyCancellable> = .init()

    init(repository: RepositoryServiceProtocol) {
        self.repository = repository

        loadData()
    }

    // MARK: - Flow state
    @Published var route: PokemonListRoute?

    func openPokemonDetail(for pokemon: Pokemon) {
        route = .pokemonDetail(pokemon)
    }

    func openPokemonDetailSheet(for pokemon: Pokemon) {
        route = .pokemonDetailSheet(pokemon)
    }

    // MARK: - ViewModelProtocol
    @Published private(set) var request: RequestState<[ModelType]> = .notAsked

    func loadData() {
        loadingCancellables.cancelAll()
        request = .loading(last: request.data)

        repository.fetchPokemonList()
            .sinkToResult { [weak self] result in
                switch result {
                case .success(let data):
                    self?.request = .success(data)
                case .failure(let error):
                    self?.request = .failure(error)
                }
            }
            .store(in: &loadingCancellables)
    }
}

#if DEBUG
    extension PokemonListViewModel {
        static var preview: Self {
            .init(repository: .mock)
        }
    }
#endif
