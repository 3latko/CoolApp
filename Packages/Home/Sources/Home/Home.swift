import Foundation
import ComposableArchitecture

public struct Home: ReducerProtocol {
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case didTapLogout
    }
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didTapLogout:
            // will be handled in the parent
            return .none
        }
    }
}
