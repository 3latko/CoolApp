import SwiftUI
import ComposableArchitecture
import Login
import Home

struct RootView: View {
    let store: StoreOf<Root>
    
    public var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /Root.State.login, action: Root.Action.login) { store in
                LoginView(store: store)
            }
            CaseLet(state: /Root.State.home, action: Root.Action.home) { store in
                HomeView(store: store)
            }
        }
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: Root.State(),
                reducer: Root()._printChanges()
            )
        )
    }
}
