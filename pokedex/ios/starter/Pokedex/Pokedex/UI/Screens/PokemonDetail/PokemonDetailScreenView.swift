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
    // TODO: implement content
    EmptyView()
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
