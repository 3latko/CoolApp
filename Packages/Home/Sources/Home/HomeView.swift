import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    let store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack(alignment: .topLeading) {
                Image("background", bundle: .module)
                    .resizable()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity)
                
                Button {
                    viewStore.send(.didTapLogout)
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Store(
                initialState: Home.State(),
                reducer: Home()._printChanges()
            )
        )
    }
}
