import Foundation
import ComposableArchitecture

public struct Login: ReducerProtocol {
    public struct State: Equatable {
        var username: String
        var password: String
        var errorMessage: String?
        var isLoading: Bool
        
        public init(
            username: String = "",
            password: String = "",
            errorMessage: String? = nil,
            isLoading: Bool = false
        ) {
            self.username = username
            self.password = password
            self.isLoading = isLoading
        }
    }
    
    public enum Action: Equatable {
        case didChangeUsername(String)
        case didChangePassword(String)
        case didTapLogin
        case handleLoginResult(CredentialsResult)
    }
    
    public init () {}
    
    @Dependency(\.credentialsClient) var credentialsClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didChangeUsername(let username):
            state.username = username
            return .none
            
        case .didChangePassword(let password):
            state.password = password
            return .none
            
        case .didTapLogin:
            var invalidCharacterSet = CharacterSet()
            invalidCharacterSet.insert(charactersIn: "0123456789!@#$%^&*(),.;'[]<>?:|{}-=_+")

            if state.username.rangeOfCharacter(from: invalidCharacterSet) != nil {
                state.errorMessage = "Username must only contain letters"
                return .none
            }
            
            state.isLoading = true
            return .task { [username = state.username, password = state.password] in
                let result = try await self.credentialsClient.validateCredentials(username, password)
                return .handleLoginResult(result)
            }
            
        case .handleLoginResult(let result):
            state.isLoading = false
            
            switch result {
            case .valid:
                state.errorMessage = nil
                return .none
            case .invalid(let message):
                state.errorMessage = message
                return .none
            }
        }
    }
}
