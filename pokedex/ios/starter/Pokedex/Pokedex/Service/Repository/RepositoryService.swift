import Combine
import Foundation

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
  // MARK: RepositoryServiceProtocol
  func fetchPokemonList() -> Single<[Pokemon], Error> {
    // TODO: link API
    Empty().asSingle()
  }
  func fetchPokemonDetail(for id: Int) -> Single<Pokemon.Detail, Error> {
    // TODO: link API
    Empty().asSingle()
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
