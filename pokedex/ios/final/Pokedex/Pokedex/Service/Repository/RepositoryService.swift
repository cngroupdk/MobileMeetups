import Combine
import Foundation
import PokemonAPI

// MARK: - RepositoryServiceProtocol
protocol RepositoryServiceProtocol: ServiceProtocol {
    func fetchPokemonList() -> Single<[Pokemon], Error>
    func fetchPokemonDetail(for id: Int) -> Single<Pokemon.Detail, Error>
    func imageURL(for id: Int) -> URL?
}

extension RepositoryServiceProtocol {
    func imageURL(for id: Int) -> URL? {
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
                        let url = URL(string: urlString),
                        let id = Int(url.lastPathComponent)
                    else { return nil }
                    let imageURL = self?.imageURL(for: id)
                    return .init(id: id, name: name, imageUrl: imageURL)
                } ?? []
            }
            .asSingle()
    }

    func fetchPokemonDetail(for id: Int) -> Single<Pokemon.Detail, Error> {
        pokemonService.fetchPokemon(id)
            .tryMap { object -> Pokemon.Detail in
                let type = object.types?.first?.type?.name
                return .init(type: type)
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
                    pokemon(id: 1, name: "bulbasaur"),
                    pokemon(id: 2, name: "ivysaur"),
                    pokemon(id: 3, name: "venusaur"),
                    pokemon(id: 4, name: "charmander"),
                    pokemon(id: 5, name: "charmeleon"),
                    pokemon(id: 6, name: "charizard"),
                ].compactMap { $0 }
            )
            .setFailureType(to: Swift.Error.self)
            .asSingle()
        }
        func fetchPokemonDetail(for id: Int) -> Single<Pokemon.Detail, Error> {
            Empty().asSingle()
        }
    }

    // MARK: Private Helper
    extension MockRepositoryService {
        fileprivate func pokemon(id: Int, name: String) -> Pokemon? {
            .init(
                id: id,
                name: name,
                imageUrl: imageURL(for: id)
            )
        }
    }
#endif
