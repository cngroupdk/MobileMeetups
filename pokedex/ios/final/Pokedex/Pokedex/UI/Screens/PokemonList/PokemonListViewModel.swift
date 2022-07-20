import Combine
import Foundation
import SwiftUI

protocol PokemonListViewModelProtocol: ObservableObject {
    typealias ModelType = Pokemon

    var request: RequestState<[ModelType]> { get }
    var pokemons: [ModelType] { get set }
    var filteredPokemons: [ModelType] { get }
    var searchText: String { get set }

    func loadData()
}

final class PokemonListViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol {

    private let repository: RepositoryServiceProtocol
    private var loadingCancellables: Set<AnyCancellable> = .init()

    init(repository: RepositoryServiceProtocol) {
        self.repository = repository
        loadData()
    }

    private func updateFilteredResult() {
        let backup = request.data ?? []
        filteredPokemons =
            searchText.isEmpty
            ? backup
            : backup.filter {
                $0.name.lowercased().contains(searchText.lowercased())
                    || String($0.id).contains(searchText)
            }
    }

    // MARK: - Flow state
    @Published var route: PokemonListRoute?

    func openPokemonDetail(for pokemon: Binding<Pokemon>) {
        route = .pokemonDetail(pokemon)
    }

    func openPokemonDetailSheet(for pokemon: Binding<Pokemon>) {
        route = .pokemonDetailSheet(pokemon)
    }

    // MARK: - ViewModelProtocol
    @Published var filteredPokemons: [ModelType] = []
    @Published private(set) var request: RequestState<[ModelType]> = .notAsked {
        didSet { updateFilteredResult() }
    }
    var searchText: String = "" {
        didSet { updateFilteredResult() }
    }
    var pokemons: [ModelType] {
        get { request.data ?? [] }
        set { request = .success(newValue) }
    }

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
