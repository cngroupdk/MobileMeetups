import Foundation

protocol PokemonListViewModelProtocol: ObservableObject {}

final class PokemonListViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol {

    private let repository: RepositoryServiceProtocol

    init(repository: RepositoryServiceProtocol) {
        self.repository = repository
    }

    // MARK: - Flow state
    @Published var route: PokemonListRoute?
}

#if DEBUG
    extension PokemonListViewModel {
        static var preview: Self {
            .init(repository: .mock)
        }
    }
#endif
