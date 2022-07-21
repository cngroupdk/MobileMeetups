import SwiftUI

@main
struct PokedexApp: App {

  private let container: DIContainer

  init() {
    let repositoryService = RepositoryService()
    let elements: [ServiceProtocol] = [
      repositoryService
    ]

    self.container = DIContainer(
      services: .init(elements: elements)
    )
  }

  var body: some Scene {
    WindowGroup {
      if let repository = container.services[RepositoryServiceProtocol.self] {
        PokemonListScreenView(
          viewModel: PokemonListViewModel(repository: repository)
        )
        .environmentObject(container)
      }
    }
  }
}
