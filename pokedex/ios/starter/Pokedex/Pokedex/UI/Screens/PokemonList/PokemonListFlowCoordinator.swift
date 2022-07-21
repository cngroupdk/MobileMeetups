import Foundation
import SwiftUI
import SwiftUINavigation

// MARK: - PokemonListFlowStateProtocol
protocol PokemonListFlowStateProtocol: ObservableObject {}

// MARK: - Route
enum PokemonListRoute {}

// MARK: - PokemonListFlowCoordinator
struct PokemonListFlowCoordinator<
    State: PokemonListFlowStateProtocol,
    Content: View
>: View {
    @ObservedObject var state: State

    let content: () -> Content

    var body: some View {
        // TODO: implement content and navigation
        EmptyView()
    }
}
