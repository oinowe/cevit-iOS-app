//
//  ResetNewPasswordView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct ResetNewPasswordView: View {
    
    // MARK: Variables
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var isSecure: Bool = false
    @State private var isSecureConfirmPassword: Bool = false
    @StateObject private var model = ResetNewPasswordViewModel()

    
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Ingresa tu nueva contraseña")
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .foregroundStyle(.black)
                    Spacer()
                } //: HStack
                .padding(.top, 50)
                
                
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
                
                
                HStack {
                    Group{
                        if isSecureConfirmPassword {
                            SecureField("Confirmar contraseña", text: $confirmPassword)
                        } else {
                            TextField("Confirmar contraseña", text: $confirmPassword)
                        }
                    }
                    .font(.system(size: 20))
                    .padding(.leading, 20)
                    .accentColor(.mainColor)
                    .textFieldStyle(.roundedBorder)
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            isSecureConfirmPassword.toggle()
                        }, label: {
                            Image(systemName: !isSecureConfirmPassword ? "eye.slash" : "eye" )
                        })
                        .padding(.trailing, 10)
                        .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                } //: HStack
                .padding(.bottom, 50)
                
                
                OnboardingContinueButton(action: {
                    if self.password == self.confirmPassword && self.password != "" {
                        model.isLoadingAPI = true
                        Task {
                            await model.changePassword(password: self.password)
                        }
                    } // TODO: Put the else error here
                }, title: "Continuar", isLoading: $model.isLoadingAPI)
                
                Spacer()
            } //: VStack
        } //: ZStack
        .navigationTitle("Cambiar contraseña")
        .fullScreenCover(isPresented: $model.moveToHome, content: {
            TabBarView()
        })
    }
}

#Preview {
    ResetNewPasswordView()
}
