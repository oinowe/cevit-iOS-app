//
//  RegisterView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 28/02/24.
//

import SwiftUI


struct RegisterView: View {
    
    // MARK: Variables
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isOTPShown: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var isLoadingAPI: Bool = false
    @State private var isSecure: Bool = false
    @StateObject private var model = EmailLoginModel()
    @State private var userLoggedIn = false
    
    // MARK: Body
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Ingresa todos los datos para registrar tu cuenta")
                    .font(.system(size: 16, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 2)
                    .foregroundStyle(.black)
                
                
                HStack {
                    TextField("Email", text: $email)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                        .focused($isTextFieldFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isTextFieldFocused = true
                            }
                        }
                        .accentColor(.mainColor)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                } //: HStack
                .padding(.bottom, 20)
                .padding(.top, 16)
                
                
                HStack {
                    Group{
                        if isSecure {
                            SecureField("Contraseña", text: $password)
                        } else {
                            TextField("Contraseña", text: $password)
                        }
                    }
                    .font(.system(size: 20))
                    .padding(.leading, 20)
                    .accentColor(.mainColor)
                    .textFieldStyle(.roundedBorder)
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            isSecure.toggle()
                        }, label: {
                            Image(systemName: !isSecure ? "eye.slash" : "eye" )
                        })
                        .padding(.trailing, 10)
                        .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                } //: HStack
                .padding(.bottom, 20)
                
                
                // MARK: Confirm passowrd
                HStack {
                    Group{
                        if isSecure {
                            SecureField("Confirma tu contraseña", text: $password)
                        } else {
                            TextField("Confirma tu contraseña", text: $password)
                        }
                    }
                    .font(.system(size: 20))
                    .padding(.leading, 20)
                    .accentColor(.mainColor)
                    .textFieldStyle(.roundedBorder)
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            isSecure.toggle()
                        }, label: {
                            Image(systemName: !isSecure ? "eye.slash" : "eye" )
                        })
                        .padding(.trailing, 10)
                        .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                } //: HStack
                .padding(.bottom, 20)
                
                // MARK: Phone number
                HStack {
                    TextField("Número telefónico", text: $email)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                        .focused($isTextFieldFocused)
                        .accentColor(.mainColor)
                        .keyboardType(.phonePad)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                } //: HStack
                .padding(.bottom, 20)
                
                
                // MARK: Name
                HStack {
                    TextField("Nombre", text: $email)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                        .focused($isTextFieldFocused)
                        .accentColor(.mainColor)
                        .keyboardType(.default)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                } //: HStack
                .padding(.bottom, 20)
                
                
                // MARK: last name
                HStack {
                    TextField("Apellido", text: $email)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                        .focused($isTextFieldFocused)
                        .accentColor(.mainColor)
                        .keyboardType(.default)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                } //: HStack
                .padding(.bottom, 20)
                
                
                
                OnboardingContinueButton(action: {
                    self.isLoadingAPI = true
                    Task {
                        // self.userLoggedIn = true
                        //await model.signUp(username: UUID().uuidString, password: <#T##String#>, email: <#T##String#>)
                    }
                }, title: "Continuar", isLoading: $isLoadingAPI)
                
                
//                NavigationLink(destination: EmailOTPView(), isActive: $isOTPShown) {
//                    EmptyView()
//                }
                
                Spacer()
            } //: VStack
        } //: ZStack
        .navigationTitle("Registrate")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $userLoggedIn, content: {
            TabBarView()
        })
    }
}

#Preview {
    RegisterView()
}
