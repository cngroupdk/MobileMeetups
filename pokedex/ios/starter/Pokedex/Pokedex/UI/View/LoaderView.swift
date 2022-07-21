import SwiftUI

typealias LoadingView = () -> AnyView

struct LoaderView<Data, Content: View>: View {

    private let requestState: RequestState<Data>
    private let renderLoadingContentOnNotAskedState: Bool
    private let onNotAsked: () -> Void
    private let loadingView: LoadingView
    private let renderView: (Data) -> Content

    init(
        requestState: RequestState<Data>,
        renderLoadingContentOnNotAskedState: Bool = true,
        onNotAsked: @escaping () -> Void = {},
        @ViewBuilder loadingView: @escaping LoadingView = {
            Self.loadingView.eraseToAnyView()
        },
        @ViewBuilder renderView: @escaping (Data) -> Content
    ) {
        self.requestState = requestState
        self.renderLoadingContentOnNotAskedState =
            renderLoadingContentOnNotAskedState
        self.onNotAsked = onNotAsked
        self.loadingView = loadingView
        self.renderView = renderView
    }

    var body: some View {
        VStack(spacing: 0) {
            self.contentView()
        }
    }

    @ViewBuilder
    static var loadingView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func contentView() -> AnyView {
        switch requestState {
        case .notAsked:
            let view =
                renderLoadingContentOnNotAskedState
                ? loadingView() : Color.clear.eraseToAnyView()
            return
                view
                .onAppear { onNotAsked() }
                .eraseToAnyView()

        case let .loading(last: maybeData):
            guard let data = maybeData else {
                return loadingView()
            }
            return renderView(data).eraseToAnyView()

        case .failure(let error):
            return ErrorView(
                error: .general(error.localizedDescription),
                action: onNotAsked
            )
            .frame(maxHeight: .infinity)
            .eraseToAnyView()

        case .success(let data):
            return renderView(data).eraseToAnyView()
        }
    }
}
