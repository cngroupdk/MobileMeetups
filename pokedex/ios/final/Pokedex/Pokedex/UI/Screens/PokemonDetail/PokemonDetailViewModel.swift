import Combine
import Foundation
import SwiftUI

// MARK: - PokemonDetailViewModelProtocol
protocol PokemonDetailViewModelProtocol: ObservableObject {
    var request: RequestState<Pokemon> { get }
    var pokemon: Pokemon { get }

    func loadDetailIfNeeded()
}

// MARK: - PokemonDetailViewModel
final class PokemonDetailViewModel: PokemonDetailViewModelProtocol & PokemonDetailFlowStateProtocol
{
    
    private let repository: RepositoryServiceProtocol
    private var loadingCancellables: Set<AnyCancellable> = .init()
    
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
    @Binding var pokemon: Pokemon
    @Published private(set) var request: RequestState<Pokemon> = .notAsked

    func loadDetailIfNeeded() {
        guard pokemon.detail == nil else {
            request = .success(pokemon)
            return
        }

        loadingCancellables.cancelAll()
        request = .loading(last: pokemon)
        repository.fetchPokemonDetail(for: pokemon.id)
            .sinkToResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let detail):
                    self.pokemon = self.pokemon.updated(with: detail)
                    self.request = .success(self.pokemon)
                case .failure(let error):
                    self.request = .failure(error)
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
