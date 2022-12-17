import SwiftUI
import Login
import ComposableArchitecture

@main
struct LoginDemoApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(
                store: Store(
                    initialState: Login.State(username: "Zlatko", password: "12345678"),
                    reducer: Login()._printChanges()
                )
            )
        }
    }
}
