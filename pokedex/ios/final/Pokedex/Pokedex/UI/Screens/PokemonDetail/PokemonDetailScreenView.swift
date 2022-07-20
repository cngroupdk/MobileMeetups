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
        GeometryReader { geometry in
            VStack {
                VStack {
                    viewModel.pokemon.imageUrl.map {
                        AsyncImage(url: $0) { image in
                            image
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                        } placeholder: {
                            Color.clear
                        }
                    }
                }
                .frame(minHeight: geometry.size.height / 3 )
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5228168533509037, saturation: 0.25107068900602414, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.6437547063253013, saturation: 0.40718244070030124, brightness: 0.8, opacity: 1.0), location: 0.9997521033653847)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
                
                VStack {
                    Text("#\(viewModel.pokemon.id) \(viewModel.pokemon.name.capitalized)")
                        .font(.title)
                        .bold()
                        .tracking(2)
                        .padding(.top)
                        .opacity(0.7)
                    
                    Text(viewModel.pokemon.detail?.type ?? "")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding(.bottom)
                
                InfoLine(label: "Weight", value: "Evolution pokemon")
                InfoLine(label: "Height", value: "Evolution pokemon")
                InfoLine(label: "Species", value: "Evolution pokemon")
                InfoLine(label: "Species", value: "Evolution pokemon")
                InfoLine(label: "Species", value: "Evolution pokemon")
                InfoLine(label: "Species", value: "Evolution pokemon")
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct InfoLine: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
                .padding(.trailing, 50)
            
            Text(value)
            Spacer()
        }
        .padding(.bottom)
        .padding(.leading, 50)
    }
}
