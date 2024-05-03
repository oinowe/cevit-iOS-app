//
//  InfoView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct InfoView: View {
    
    @StateObject private var viewModel = InfoViewModel()
    @State private var isLoading = false
    
    var body: some View {
            
        // MARK: VStack for elements of user
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                VStack(alignment: .leading) {
                    Text("Hola \(viewModel.userData?.name ?? "")")
                        .fontWeight(.heavy)
                        .font(.headline)
                    Text(viewModel.userData?.email ?? "")
                        .font(.subheadline)
                    Text(viewModel.userData?.phone_number ?? "")
                        .font(.subheadline)
                }
            }
            Text("Cliente: \(viewModel.userData?.client_name ?? "")")
            Text("Tipo: \(viewModel.userData?.type ?? "")")
            Text("Grupo de permisos: \(viewModel.userData?.permission_name ?? "")")
            Text("Muestras restantes: \(String(viewModel.userData?.samples_left ?? 0))")
            
            Spacer()
            
            // MARK: Logout
            OnboardingContinueButton(action: {
                Task {
                    await viewModel.signOutLocally()
                }
            }, title: "Cerrar sesión", isLoading: $isLoading)
        }
        .padding(.vertical, 20)
        .fullScreenCover(isPresented: $viewModel.returnToHome, content: {
            SignUpView()
        })
    }
}

#Preview {
    InfoView()
}
