import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

public enum CredentialsResult: Equatable {
    case valid
    case invalid(message: String)
}

public struct CredentialsClient {
    public var validateUsername: (String) -> CredentialsResult
    public var authenticate: (String, String) async throws -> CredentialsResult
}

extension CredentialsClient {
    static let live = Self(
        validateUsername: { username in
            var invalidCharacterSet = CharacterSet()
            invalidCharacterSet.insert(charactersIn: "0123456789!@#$%^&*(),.;'[]<>?:|{}-=_+")
            
            if username.rangeOfCharacter(from: invalidCharacterSet) != nil {
                return .invalid(message: "Username must contain only letters")
            }
            return .valid
        },
        authenticate: { username, password in
            // simulate network request
            try await Task.sleep(for: .seconds(0.5))
            
            if username != "Zlatko" {
                return .invalid(message: "Wrong username")
            }
            if password != "12345678" {
                return .invalid(message: "Wrong password")
            }
            return .valid
        }
    )
}

extension CredentialsClient {
    static let unimplemented = Self(
        validateUsername: XCTUnimplemented("\(Self.self).validateUsername"),
        authenticate: XCTUnimplemented("\(Self.self).authenticate")
    )
}

public extension DependencyValues {
    var credentialsClient: CredentialsClient {
        get { self[CredentialsClientKey.self] }
        set { self[CredentialsClientKey.self] = newValue }
    }
}

private enum CredentialsClientKey: DependencyKey {
    public static let liveValue = CredentialsClient.live
    public static let testValue = CredentialsClient.unimplemented
}
