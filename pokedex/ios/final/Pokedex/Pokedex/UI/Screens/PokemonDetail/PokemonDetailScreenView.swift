import SwiftUI

struct PokemonDetailScreenView<
    ViewModel: PokemonDetailViewModelProtocol & PokemonDetailFlowStateProtocol
>: View {
    
    @StateObject var viewModel: ViewModel
    
    let imageSize: CGFloat = 280
    
    var body: some View {
        PokemonDetailFlowCoordinator(state: viewModel, content: content)
    }
    
    @ViewBuilder
    private func content() -> some View {
        LoaderView(
            requestState: viewModel.request,
            onNotAsked: { viewModel.loadDetailIfNeeded() }
        ) { pokemon in
            GeometryReader { geometry in
                VStack {
                    Header(imageUrl: viewModel.pokemon.imageUrl, headerMinHeight: geometry.size.height / 3)
                    
                    Title(id: pokemon.id, name: pokemon.name, type: pokemon.detail?.type)
                    
                    StatInfo(
                        label: "Base Experience",
                        value: viewModel.pokemon.detail?.baseExperience
                    )
                    
                    StatInfo(
                        label: "Weight",
                        value: viewModel.pokemon.detail?.weight
                    )
                    
                    StatInfo(
                        label: "Height",
                        value: viewModel.pokemon.detail?.height
                    )
                    
                    StatInfo(
                        label: "HP",
                        value: viewModel.pokemon.detail?.hp
                    )
                    
                    StatInfo(
                        label: "Attack",
                        value: viewModel.pokemon.detail?.attack
                    )
                }
                
                Spacer()
            }
        }
    }
}

#if DEBUG
struct PokemonDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailScreenView<PokemonDetailViewModel>(
            viewModel: .preview
        )
    }
}
#endif

struct Title: View {
    let id: Int
    let name: String
    let type: String?
    
    var body: some View {
        VStack {
            Text("#\(id) \(name.capitalized)")
                .font(.title)
                .bold()
                .tracking(2)
                .padding(.top)
                .opacity(0.7)
            
            Text(type ?? "")
                .font(.caption)
                .bold()
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
        .padding(.bottom)
    }
}
