import SwiftUI
import Home
import ComposableArchitecture

@main
struct HomeDemoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: Store(
                    initialState: Home.State(),
                    reducer: Home()._printChanges()
                )
            )
        }
    }
}
