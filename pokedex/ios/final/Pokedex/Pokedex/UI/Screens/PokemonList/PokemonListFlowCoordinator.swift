import Foundation
import SwiftUI
import SwiftUINavigation

// MARK: - PokemonListFlowStateProtocol
protocol PokemonListFlowStateProtocol: ObservableObject {
    var route: PokemonListRoute? { get set }

    func openPokemonDetail(for pokemon: Binding<Pokemon>)
}

// MARK: - Route
enum PokemonListRoute {
    case pokemonDetail(Binding<Pokemon>)

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
    @EnvironmentObject var container: DIContainer
    @ObservedObject var state: State

    let content: () -> Content

    private var activeSheet: Binding<PokemonListRoute?> {
        $state.route.map(get: { $0?.modal }, set: { $0 })
    }

    var body: some View {
        NavigationView {
            content()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(
            unwrapping: activeSheet,
            case: /PokemonListRoute.pokemonDetail,
            content: pokemonDetailDestination
        )
    }

    // MARK: Destinations
    @ViewBuilder
    private func pokemonDetailDestination(_ binding: Binding<Binding<Pokemon>>) -> some View {
        IfLet(.constant(container.services[RepositoryServiceProtocol.self])) { $repository in
            PokemonDetailScreenView(
                viewModel: PokemonDetailViewModel(
                    repository: repository,
                    pokemon: binding.wrappedValue
                )
            )
        }
    }
}
