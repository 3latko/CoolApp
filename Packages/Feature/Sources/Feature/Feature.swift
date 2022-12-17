import Foundation
import ComposableArchitecture

public struct Feature: ReducerProtocol {
    public struct State: Equatable {
        // state
        
        public init(
            // state default values
        ) {
            // assign the values
        }
    }
    
    public enum Action: Equatable {
        // actions
    }
    
    // dependencies
    // @Dependency(\.mainQueue) var mainQueue
    
    public init() {}
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            // handle action enum
        }
        return .none
    }
}
