import Combine
import Foundation
import SwiftUI

// MARK: - PokemonListViewModelProtocol
protocol PokemonListViewModelProtocol: ObservableObject {
    typealias ModelType = Pokemon

    var request: RequestState<[ModelType]> { get }
    var pokemons: [ModelType] { get set }

    func loadData()
}

// MARK: - PokemonListViewModel
final class PokemonListViewModel: PokemonListViewModelProtocol & PokemonListFlowStateProtocol {

    init(repository: RepositoryServiceProtocol) {}

    // MARK: - Flow state
    // TODO: implement flow state protocol

    // MARK: - ViewModelProtocol
    @Published private(set) var request: RequestState<[ModelType]> = .notAsked
    var pokemons: [ModelType] {
        get { [] }
        set {}
    }

    func loadData() {}
}

#if DEBUG
    extension PokemonListViewModel {
        static var preview: Self {
            .init(repository: .mock)
        }
    }
#endif
