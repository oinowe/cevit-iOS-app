//
//  LoginView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import SwiftUI

struct EmailLoginView: View {
    
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
                HStack {
                    Text("Ingresa tu correo")
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .foregroundStyle(.black)
                    Spacer()
                } //: HStack
                .padding(.top, 50)
                
                
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
                .padding(.bottom, 50)
                
                
                OnboardingContinueButton(action: {
                    self.isOTPShown = true
                    Task {
                        self.userLoggedIn = true
                        //await model.signUp(username: UUID().uuidString, password: <#T##String#>, email: <#T##String#>)
                    }
                }, title: "Continuar", isLoading: $isLoadingAPI)
                
                
//                NavigationLink(destination: EmailOTPView(), isActive: $isOTPShown) {
//                    EmptyView()
//                }
                
                Spacer()
            } //: VStack
        } //: ZStack
        .navigationTitle("Iniciar sesion")
        .fullScreenCover(isPresented: $userLoggedIn, content: {
            TabBarView()
        })
    }
}

#Preview {
    EmailLoginView()
}
