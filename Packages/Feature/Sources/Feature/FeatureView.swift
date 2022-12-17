import SwiftUI
import ComposableArchitecture

public struct FeatureView: View {
    let store: StoreOf<Feature>
    
    public init(store: StoreOf<Feature>) {
        self.store = store
    }
    
    public var body: some View {
        Text("Hello, Feature!")
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(
            store: Store(
                initialState: Feature.State(),
                reducer: Feature()._printChanges()
            )
        )
    }
}
