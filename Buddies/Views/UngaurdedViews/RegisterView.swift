
import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var showPassword: Bool = false
    @State private var showRegisterSuccess = false
    @State private var isChecked: Bool = false
    @State private var showEmailField = false
    @State private var showPasswordField = false
    @State private var showConfirmPasswordField = false
    @State private var showAgreeTerms = false
    @State private var showBottomElements = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Title
            Text("Register")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 100)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Email Field
            if showEmailField {
                TextField("Email", text: $email, prompt: Text("Email").foregroundColor(.white))
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                    }
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                    .transition(.opacity)
                    .offset(y: showEmailField ? 0 : -20)
                    .animation(.easeInOut(duration: 0.5), value: showEmailField)
            }
            
            // Password Field
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
                    
                    // Toggle Password Visibility
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
                .transition(.opacity)
                .offset(y: showPasswordField ? 0 : -20)
                .animation(.easeInOut(duration: 0.5), value: showPasswordField)
            }
            
            // Confirm Password Field
            if showConfirmPasswordField {
                SecureField(
                    "Confirm Password", text: $confirmPassword,
                    prompt: Text("Confirm Password").foregroundColor(.white)
                )
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .disableAutocorrection(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                }
                .padding(.horizontal)
                .textInputAutocapitalization(.never)
                .transition(.opacity)
                .offset(y: showConfirmPasswordField ? 0 : -20)
                .animation(.easeInOut(duration: 0.5), value: showConfirmPasswordField)
            }
            
            // Error Message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .transition(.opacity)
                    .offset(y: showEmailField ? 0 : -20)
                    .animation(.easeInOut(duration: 0.5), value: showEmailField)
            }
            
            // Agree to Terms
            if showAgreeTerms {
                HStack {
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    }
                  
                        Text("Agree to Convoy terms of service")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                    
                }
                .padding(.horizontal)
                .transition(.opacity)
                .offset(y: showAgreeTerms ? 0 : -20)
                .animation(.easeInOut(duration: 0.5), value: showAgreeTerms)
            }
            
            Spacer()
            
            // Bottom Elements
            if showBottomElements {
                VStack(spacing: 10) {
                    NavigationLink(destination: LoginView()) {
                        HStack {
                            Text("Already have an account?")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Login.")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 20)
                    .navigationTitle("")
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                    } else {
                        Button {
                            
                        } label: {
                            Text("Register")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(isFormValid() ? Color.white : Color.gray)
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                        .disabled(!isFormValid())
                    }
                    
                    Text("domi & Nathan™")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 30)
                        .padding(.top, 10)
                }
                .transition(.opacity)
                .offset(y: showBottomElements ? 0 : -20)
                .animation(.easeInOut(duration: 0.5), value: showBottomElements)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showRegisterSuccess) {
            Alert(
                title: Text("Success"), message: Text("User registered successfully"),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                showEmailField = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showPasswordField = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showConfirmPasswordField = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showAgreeTerms = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showBottomElements = true
                }
            }
        }
    }
    
    private func isFormValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && password == confirmPassword && isChecked
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
