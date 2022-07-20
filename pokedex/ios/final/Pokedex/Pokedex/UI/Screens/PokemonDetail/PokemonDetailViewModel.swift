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
