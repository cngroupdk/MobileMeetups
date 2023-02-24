import SwiftUI

@main
struct iOSApp: App {

    init() {
        if !ProcessInfo.isSwiftUIPreview {
            Koin.start()
        }
    }

    var body: some Scene {
        WindowGroup {
            PokemonListScreenView(viewModelWrapper: .init())
        }
    }
}
