//
//  AddUsersView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import SwiftUI

struct AddUsersView: View {
    
    // MARK: Vars
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddUsersViewModel()
    @State private var nameText: String = ""
    @State private var lastNameText: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var type: String = ""
    @State private var isLoading: Bool = false
    @State private var externalUser: Bool = false
    var clientName: String
    var clientId: Int
    var reloadUsers: () -> Void
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nuevo usuario a \(clientName)")
                
                TextField("Nombre", text: $nameText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Apellido", text: $lastNameText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Telefono", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Tipo de usuario", text: $type)
                    .textFieldStyle(.roundedBorder)
                
                Toggle("Usuario externo: ", isOn: $externalUser)
                    .padding(.horizontal, 40)
                
                Picker("Tipo de permiso: ", selection: $viewModel.selectedPermission) {
                    ForEach(viewModel.permissions, id: \.self) {
                        Text("\($0.name)")
                    }
                }
                .pickerStyle(.menu)
                
                
                OnboardingContinueButton(action: {
                    
                    guard let permissionId = viewModel.selectedPermission?.id else { return }
                    
        
                    self.isLoading = true
                    viewModel.createUser(clientId: clientId, name: nameText, lastName: lastNameText, email: email, phoneNumber: phoneNumber, type: type, external: externalUser, permissionsId: permissionId) { status in
                        self.isLoading = false
                        if status { self.reloadUsers() }
                    }
                }, title: "Agregar usuario", isLoading: $isLoading)
                
                Spacer()
            }
            .padding(12)
            .onChange(of: viewModel.dismissView, perform: { _ in
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    AddUsersView(clientName: "Finca", clientId: 1, reloadUsers: {})
}
