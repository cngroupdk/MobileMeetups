import Foundation

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
        pokemon: Pokemon
    ) {
        self.repository = repository
        self.pokemon = pokemon
    }

    // MARK: - Flow state
    @Published var route: PokemonDetailRoute?

    // MARK: - ViewModelProtocol
    let pokemon: Pokemon
}

#if DEBUG
    extension PokemonDetailViewModel {
        static var preview: Self {
            .init(
                repository: .mock,
                pokemon:
                    .init(
                        name: "bulbasaur",
                        url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
                    )
            )
        }
    }
#endif
