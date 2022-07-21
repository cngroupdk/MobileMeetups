import Combine
import Foundation
import SwiftUI

// MARK: - PokemonDetailViewModelProtocol
protocol PokemonDetailViewModelProtocol: ObservableObject {
    var pokemonRequest: RequestState<Pokemon> { get }

    func loadDetailIfNeeded()
}

// MARK: - PokemonDetailViewModel
final class PokemonDetailViewModel: PokemonDetailViewModelProtocol & PokemonDetailFlowStateProtocol
{
    private let repository: RepositoryServiceProtocol
    private var loadingCancellables: Set<AnyCancellable> = .init()

    @Binding private var pokemon: Pokemon

    init(
        repository: RepositoryServiceProtocol,
        pokemon: Binding<Pokemon>
    ) {
        self.repository = repository
        self._pokemon = pokemon
    }

    // MARK: - Flow state
    @Published var route: PokemonDetailRoute?

    // MARK: - ViewModelProtocol
    @Published private(set) var pokemonRequest: RequestState<Pokemon> = .notAsked

    func loadDetailIfNeeded() {
        guard pokemon.detail == nil else {
            pokemonRequest = .success(pokemon)
            return
        }

        loadingCancellables.cancelAll()
        pokemonRequest = .loading(last: pokemon)
        repository.fetchPokemonDetail(for: pokemon.id)
            .sinkToResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let detail):
                    self.pokemon = self.pokemon.updated(with: detail)
                    self.pokemonRequest = .success(self.pokemon)
                case .failure(let error):
                    self.pokemonRequest = .failure(error)
                }
            }
            .store(in: &loadingCancellables)
    }

}

#if DEBUG
    extension PokemonDetailViewModel {
        static var preview: Self {
            .init(
                repository: .mock,
                pokemon: .constant(
                    .init(
                        id: 1,
                        name: "bulbasaur"
                    )
                )
            )
        }
    }
#endif
