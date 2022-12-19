import XCTest
import ComposableArchitecture
@testable import Login

final class LoginTests: XCTestCase {
    func testUsernameUpdate_whenUsernameIsValid() throws {
        let store = TestStore(
            initialState: Login.State(username: "", password: ""),
            reducer: Login()
        )
        store.send(.didChangeUsername("Username")) {
            $0.username = "Username"
        }
    }
    
    func testDidTapLogin_whenUsernameIsInvalid() {
        let store = TestStore(
            initialState: Login.State(username: "12InvalidUsername34", password: ""),
            reducer: Login()
        )
        
        store.send(.didTapLogin) {
            $0.errorMessage = "Username must only contain letters"
        }
    }
    
    @MainActor
    func testDidTapLogin_whenUsernameAndPasswordAreValid() async {
        let store = TestStore(
            initialState: Login.State(username: "ValidUsername", password: "SuperStrongPassword"),
            reducer: Login()
        )
        store.dependencies.credentialsClient.validateCredentials = { username, password in
            return .valid
        }
        
        await store.send(.didTapLogin) {
            $0.isLoading = true
        }
        await store.receive(.handleLoginResult(.valid)) {
            $0.isLoading = false
        }
    }
}
