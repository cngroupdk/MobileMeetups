import Combine
import Foundation
import SwiftUI

// MARK: - PokemonDetailViewModelProtocol
protocol PokemonDetailViewModelProtocol: ObservableObject {
    var pokemon: Pokemon { get }
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

        loadDetailIfNeeded()
    }

    private func loadDetailIfNeeded() {
        guard pokemon.detail == nil else { return }

        loadingCancellables.cancelAll()
        repository.fetchPokemonDetail(for: pokemon.id)
            .sinkToResult { [weak self] in
                guard case .success(let detail) = $0,
                    let pokemon = self?.pokemon
                else { return }
                self?.pokemon = pokemon.updated(with: detail)
            }
            .store(in: &loadingCancellables)
    }

    // MARK: - Flow state
    @Published var route: PokemonDetailRoute?

    // MARK: - ViewModelProtocol
    @Binding var pokemon: Pokemon
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
