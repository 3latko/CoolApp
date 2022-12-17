import SwiftUI
import ComposableArchitecture

public struct LoginView: View {
    let store: StoreOf<Login>
    
    public init(store: StoreOf<Login>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Image("background", bundle: .module)
                    .resizable()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Wellcome")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold))
                        .padding()
                    
                    Spacer()
                    
                    TextField("Username",
                              text: viewStore.binding(
                                get: \.username,
                                send: Login.Action.didChangeUsername
                              )
                    )
                    .textFieldStyle(CustomTextFieldStyle(isError: viewStore.errorMessage != nil))
                    .textContentType(.username)
                    
                    SecureField("Password",
                              text: viewStore.binding(
                                get: \.password,
                                send: Login.Action.didChangePassword
                              )
                    )
                    .textFieldStyle(CustomTextFieldStyle(isError: viewStore.errorMessage != nil))
                    .textContentType(.password)
                    
                    if let errorMessage = viewStore.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(.didTapLogin)
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.purple)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Text("Login")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }
                    })
                }
                .frame(alignment: .center)
                .padding()
                
                if viewStore.isLoading {
                    Color.white.opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView()
                }
            }
            .animation(.default, value: viewStore.isLoading)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    let isError: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.headline.bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(self.isError ? .red : .purple, lineWidth: 2)
            )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: Login.State(username: "Zlatko", password: "12345678"),
                reducer: Login()._printChanges()
            )
        )
    }
}
