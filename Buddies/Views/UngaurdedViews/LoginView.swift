import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showNameField = false
    @State private var showPasswordField = false
    @State private var showForgotPassword = false
    @State private var showBottomElements = false
    @State private var isLoggedIn = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    
                    Image(systemName: "arrow.left")
                        .foregroundColor(.clear)
                        .padding()
                }
                .padding(.top, 40)
                .background(Color.black)
                
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if showNameField {
                    TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.white))
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        }
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                        .transition(.opacity)
                        .offset(y: showNameField ? 0 : -20)
                        .animation(.easeInOut(duration: 0.5), value: showNameField)
                }
                
                if showPasswordField {
                    ZStack(alignment: .trailing) {
                        Group {
                            if showPassword {
                                TextField("Password", text: $password, prompt: Text("Password").foregroundColor(.white))
                                    .textInputAutocapitalization(.never)
                            } else {
                                SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.white))
                                    .textInputAutocapitalization(.never)
                            }
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                    .offset(y: showPasswordField ? 0 : -20)
                    .animation(.easeInOut(duration: 0.5), value: showPasswordField)
                }
                
                if showForgotPassword {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    
                    .padding(.horizontal)
                    .frame(height: 20)
                    .transition(.opacity)
                    .offset(y: showForgotPassword ? 0 : -20)
                    .animation(.easeInOut(duration: 0.5), value: showForgotPassword)
                }
                
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .transition(.opacity)
                        .offset(y: showError ? 0 : -20)
                        .animation(.easeInOut(duration: 0.5), value: showError)
                }
                
                Spacer()
                
                if showBottomElements {
                    VStack(spacing: 10) {
                        NavigationLink(destination: ContentView(), isActive: $isLoggedIn) { // Navigate to MainView when isLoggedIn is true
                            EmptyView()
                        }
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding()
                        } else {
                            Button {
                            } label: {
                                Text("Login")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(isSignInButtonDisabled ? Color.gray : Color.white)
                                    .cornerRadius(8)
                                    .disabled(isSignInButtonDisabled)
                                    .padding(.horizontal)
                            }
                            .transition(.opacity)
                            .offset(y: showBottomElements ? 0 : -20)
                            .animation(.easeInOut(duration: 0.5), value: showBottomElements)
                        }
                        
                        Text("domi & Nathan™")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 10)
                    }
                    .transition(.opacity)
                    .offset(y: showBottomElements ? 0 : -20)
                    .animation(.easeInOut(duration: 0.5), value: showBottomElements)
                }
                
                Spacer()
                    .frame(height: 10)
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showNameField = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showPasswordField = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showForgotPassword = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showBottomElements = true
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
