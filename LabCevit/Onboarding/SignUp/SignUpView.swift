//
//  SignUpView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: Variables
    @State private var isEmailViewShown = false
    @State private var isLoginViewShown = false
    
    // MARK: Body
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Bienvenido a")
                    .font(.system(size: 32))
                    .foregroundStyle(.black)
                
                Text("Cevit")
                    .font(.system(size: 60))
                    .foregroundStyle(.black)
                
                Image(systemName: "")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 150)
                
                Spacer()
                
                NavigationLink(destination: RegisterView(), isActive: $isLoginViewShown) {
                    EmptyView()
                }
                
                NavigationLink(destination: EmailLoginView(), isActive: $isEmailViewShown) {
                    EmptyView()
                }
                
                ContinueWithEmailButton(action: {
                    isEmailViewShown = true
                })
                
                OnboardingContinueButtonWithIcon(action: {
                    isLoginViewShown = true
                }, title: "Registrate", isLoading: .constant(false))
            }
            .background(Color.lightColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color.lightColor)
    }
}

#Preview {
    SignUpView()
}
