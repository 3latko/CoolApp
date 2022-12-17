import Foundation
import Login
import Home
import ComposableArchitecture

struct Root: ReducerProtocol {
    public enum State: Equatable {
        case login(Login.State)
        case home(Home.State)
        
        public init() { self = .login(Login.State()) }
    }
    
    public enum Action: Equatable {
        case login(Login.Action)
        case home(Home.Action)
    }
    
    // dependencies
    // @Dependency(\.mainQueue) var mainQueue
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .login(.handleLoginResult(.valid)):
                state = .home(.init())
                return .none
                
            case .home(.didTapLogout):
                state = .login(.init())
                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(/State.login, action: /Action.login) {
          Login()
        }
        .ifCaseLet(/State.home, action: /Action.home) {
          Home()
        }
    }
}

enum Route: Equatable {
    case login
    case home
}
