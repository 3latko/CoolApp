import SwiftUI
import Feature
import ComposableArchitecture

@main
struct FeatureDemoApp: App {
    var body: some Scene {
        WindowGroup {
            FeatureView(
                store: Store(
                    initialState: Feature.State(),
                    reducer: Feature()._printChanges()
                )
            )
        }
    }
}
