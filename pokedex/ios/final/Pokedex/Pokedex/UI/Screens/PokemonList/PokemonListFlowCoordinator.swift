import Foundation
import SwiftUI
import SwiftUINavigation

// MARK: - PokemonListFlowStateProtocol
protocol PokemonListFlowStateProtocol: ObservableObject {
    var route: PokemonListRoute? { get set }
}

// MARK: - Route
enum PokemonListRoute {
    case pokemonDetail

    var navigationLink: PokemonListRoute? {
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

    private var activeLink: Binding<PokemonListRoute?> {
        $state.route.map(get: { $0?.navigationLink }, set: { $0 })
    }

    var body: some View {
        NavigationView {
            ZStack {
                content()
                navigationLinks
            }
        }
    }

    @ViewBuilder
    private var navigationLinks: some View {
        ZStack {
            NavigationLink(
                unwrapping: activeLink,
                case: /PokemonListRoute.pokemonDetail,
                destination: pokemonDetailDestination,
                onNavigate: { _ in },
                label: { EmptyView() }
            )
        }
    }

    // MARK: Destinations
    @ViewBuilder
    private func pokemonDetailDestination(_ binding: Binding<Void>) -> some View {
        Color.red
    }
}
