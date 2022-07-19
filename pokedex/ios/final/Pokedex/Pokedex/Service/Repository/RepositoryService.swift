import Combine
import Foundation
import PokemonAPI

// MARK: - RepositoryServiceProtocol
protocol RepositoryServiceProtocol: ServiceProtocol {
    func fetchPokemonList() -> Single<[Pokemon], Error>
}

// MARK: - RepositoryService
final class RepositoryService: RepositoryServiceProtocol {

    private let pokemonAPI: PokemonAPI

    private var pokemonService: PokemonService {
        pokemonAPI.pokemonService
    }

    init() {
        self.pokemonAPI = PokemonAPI()
    }

    func fetchPokemonList() -> Single<[Pokemon], Error> {
        pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 150))
            .map { object -> [Pokemon] in
                object.results?.compactMap { resource -> Pokemon? in
                    guard let resource = resource as? PKMNamedAPIResource<PKMPokemon>,
                        let name = resource.name,
                        let urlString = resource.url,
                        let url = URL(string: urlString)
                    else { return nil }
                    return .init(name: name, url: url)
                } ?? []
            }
            .asSingle()
    }
}

// MARK: - Mock
#if DEBUG
    extension RepositoryServiceProtocol where Self == MockRepositoryService {
        static var mock: RepositoryServiceProtocol {
            MockRepositoryService()
        }
    }

    final class MockRepositoryService: RepositoryServiceProtocol {
        func fetchPokemonList() -> Single<[Pokemon], Error> {
            Empty().asSingle()
        }
    }
#endif
