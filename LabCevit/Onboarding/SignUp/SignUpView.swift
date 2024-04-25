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
                Text("Laboratorio")
                    .font(.system(size: 32))
                    .foregroundStyle(.black)
                
                Text("Cevit")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.bottom, -20)
                
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 100)
                    .clipShape(.capsule)
                
                ContinueWithEmailButton(action: {
                    isEmailViewShown = true
                })
                
                Spacer()
                NavigationLink(destination: RegisterView(), isActive: $isLoginViewShown) {
                    EmptyView()
                }
                
                NavigationLink(destination: EmailLoginView(), isActive: $isEmailViewShown) {
                    EmptyView()
                }
                
//                OnboardingContinueButtonWithIcon(action: {
//                    isLoginViewShown = true
//                }, title: "Registrate", isLoading: .constant(false))
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
