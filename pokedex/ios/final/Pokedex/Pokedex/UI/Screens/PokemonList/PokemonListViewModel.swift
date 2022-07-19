import Combine
import Foundation

protocol PokemonListViewModelProtocol: ObservableObject {
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

    func openPokemonDetail() {
        route = .pokemonDetail
    }

    func openPokemonDetailSheet() {
        route = .pokemonDetailSheet
    }

    // MARK: - ViewModelProtocol
    func loadData() {
        loadingCancellables.cancelAll()
        repository.fetchPokemonList()
            .sinkToResult { _ in }
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
