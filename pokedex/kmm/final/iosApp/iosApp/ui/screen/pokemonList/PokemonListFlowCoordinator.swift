import Foundation
import SharedKit
import SwiftUI
import SwiftUINavigation

// MARK: - PokemonListFlowStateProtocol
protocol PokemonListFlowStateProtocol: ObservableObject {
    var route: PokemonListRoute? { get set }

    func openPokemonDetail(for pokemon: Pokemon)
}

// MARK: - Route
enum PokemonListRoute {
    case pokemonDetail(Pokemon)

    var modal: PokemonListRoute? {
        switch self {
        case .pokemonDetail:
            return self
        }
    }
}

// MARK: - PokemonListFlowCoordinator
struct PokemonListFlowCoordinator<
    State: PokemonListFlowStateProtocol,
    Content: View
>: View {
    @ObservedObject var state: State

    let content: () -> Content

    private var activeSheet: Binding<PokemonListRoute?> {
        $state.route.map(get: { $0?.modal }, set: { $0 })
    }

    var body: some View {
        content()
            .sheet(
                unwrapping: activeSheet,
                case: /PokemonListRoute.pokemonDetail,
                content: pokemonDetailDestination
            )
    }

    // MARK: Destinations
    @ViewBuilder
    private func pokemonDetailDestination(_ binding: Binding<Pokemon>) -> some View {
        PokemonDetailScreenView(
            viewModelWrapper: .init(pokemonId: String(binding.wrappedValue.id))
        )
    }

}
