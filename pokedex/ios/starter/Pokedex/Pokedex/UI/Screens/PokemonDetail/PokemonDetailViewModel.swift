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
  init(
    repository: RepositoryServiceProtocol,
    pokemon: Binding<Pokemon>
  ) {
    // TODO: implement binding & data load
  }

  // MARK: - Flow state
  @Published var route: PokemonDetailRoute?

  // MARK: - ViewModelProtocol
  @Published private(set) var pokemonRequest: RequestState<Pokemon> = .notAsked

  func loadDetailIfNeeded() {}
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
