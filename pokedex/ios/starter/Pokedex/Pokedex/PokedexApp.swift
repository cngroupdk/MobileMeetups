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
        // TODO: add root view
      EmptyView()
    }
  }
}
