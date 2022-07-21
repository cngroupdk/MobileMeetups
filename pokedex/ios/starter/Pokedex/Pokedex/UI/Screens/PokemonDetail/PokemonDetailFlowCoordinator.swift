import SwiftUI

// MARK: - PokemonDetailFlowStateProtocol
protocol PokemonDetailFlowStateProtocol: ObservableObject {
  var route: PokemonDetailRoute? { get set }
}

// MARK: - Route
enum PokemonDetailRoute {

}

// MARK: - PokemonDetailFlowCoordinator
struct PokemonDetailFlowCoordinator<
  State: PokemonDetailFlowStateProtocol,
  Content: View
>: View {

  @ObservedObject var state: State

  let content: () -> Content

  var body: some View {
    content()
  }
}
