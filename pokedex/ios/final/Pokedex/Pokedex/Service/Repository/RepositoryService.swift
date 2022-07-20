import Combine
import Foundation
import PokemonAPI

// MARK: - RepositoryServiceProtocol
protocol RepositoryServiceProtocol: ServiceProtocol {
    func fetchPokemonList() -> Single<[Pokemon], Error>
    func imageURL(for id: String) -> URL?
}

extension RepositoryServiceProtocol {
    func imageURL(for id: String) -> URL? {
        URL(
            string:
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        )
    }
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

    // MARK: RepositoryServiceProtocol
    func fetchPokemonList() -> Single<[Pokemon], Error> {
        pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 150))
            .map { object -> [Pokemon] in
                object.results?.compactMap { [weak self] resource -> Pokemon? in
                    guard let resource = resource as? PKMNamedAPIResource<PKMPokemon>,
                        let name = resource.name,
                        let urlString = resource.url,
                        let url = URL(string: urlString)
                    else { return nil }
                    let id = url.lastPathComponent
                    let imageURL = self?.imageURL(for: id)
                    return .init(id: id, name: name, image: imageURL, detail: url)
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
            Just(
                [
                    pokemon(id: "1", name: "bulbasaur"),
                    pokemon(id: "2", name: "ivysaur"),
                    pokemon(id: "3", name: "venusaur"),
                    pokemon(id: "4", name: "charmander"),
                    pokemon(id: "5", name: "charmeleon"),
                    pokemon(id: "6", name: "charizard"),
                ].compactMap { $0 }
            )
            .setFailureType(to: Swift.Error.self)
            .asSingle()
        }
    }

    // MARK: Private Helper
    extension MockRepositoryService {
        fileprivate func pokemon(id: String, name: String) -> Pokemon? {
            .init(
                id: id,
                name: name,
                image: imageURL(for: id),
                detail: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")
            )
        }
    }
#endif
