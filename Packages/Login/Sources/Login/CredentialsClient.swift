import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

public enum CredentialsResult: Equatable {
    case valid
    case invalid(message: String)
}

public struct CredentialsClient {
    public var validateCredentials: (String, String) async throws -> CredentialsResult
}

extension CredentialsClient {
    static let live = Self(
        validateCredentials: { username, password in
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
        validateCredentials: XCTUnimplemented("\(Self.self).validateCredentials")
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
