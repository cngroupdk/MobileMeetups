import Foundation
import SwiftUI
import SwiftUINavigation

// MARK: - PokemonListFlowStateProtocol
protocol PokemonListFlowStateProtocol: ObservableObject {
    var route: PokemonListRoute? { get set }

    func openPokemonDetail(for pokemon: Binding<Pokemon>)
    func openPokemonDetailSheet(for pokemon: Binding<Pokemon>)
}

// MARK: - Route
enum PokemonListRoute {
    case pokemonDetail(Binding<Pokemon>)
    case pokemonDetailSheet(Binding<Pokemon>)

    var navigationLink: PokemonListRoute? {
        switch self {
        case .pokemonDetail:
            return self
        default:
            return nil
        }
    }

    var modal: PokemonListRoute? {
        switch self {
        case .pokemonDetailSheet:
            return self
        default:
            return nil
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

    private var activeSheet: Binding<PokemonListRoute?> {
        $state.route.map(get: { $0?.modal }, set: { $0 })
    }

    var body: some View {
        NavigationView {
            ZStack {
                content()
                navigationLinks
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(
            unwrapping: activeSheet,
            case: /PokemonListRoute.pokemonDetailSheet,
            content: pokemonDetailDestination
        )
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
