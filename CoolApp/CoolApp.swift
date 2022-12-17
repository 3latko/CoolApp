import SwiftUI
import ComposableArchitecture

@main
struct CoolApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: self.store)
        }
    }
}

fileprivate extension CoolApp {
    var store: StoreOf<Root> {
        Store(
            initialState: Root.State(),
            reducer: Root()
        )
    }
}
