import Foundation

protocol PokemonListViewModelProtocol: ObservableObject {}

final class PokemonListViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol {

    private let repository: RepositoryServiceProtocol

    init(repository: RepositoryServiceProtocol) {
        self.repository = repository
    }

    // MARK: - Flow state
    @Published var route: PokemonListRoute?

    func openPokemonDetail() {
        route = .pokemonDetail
    }

    func openPokemonDetailSheet() {
        route = .pokemonDetailSheet
    }
}

#if DEBUG
    extension PokemonListViewModel {
        static var preview: Self {
            .init(repository: .mock)
        }
    }
#endif
