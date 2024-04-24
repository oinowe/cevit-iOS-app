//
//  AddPermissionsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import SwiftUI

struct AddPermissionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddPermissionsViewModel()
    @State private var nameText: String = ""
    @State private var canRead: Bool = false
    @State private var canWrite: Bool = false
    @State private var canModify: Bool = false
    @State private var admin: Bool = false
    @State private var isLoading: Bool = false
    var reloadPermissions: () -> Void
    
    var body: some View {
        Section {
            Form {
                TextField("Nombre", text: $nameText)
                Toggle("Lectura", isOn: $canRead)
                Toggle("Escritura", isOn: $canWrite)
                Toggle("Modificar", isOn: $canModify)
                Toggle("Administrador", isOn: $admin)
            }
        }
        
        OnboardingContinueButton(action: {
                    
            self.isLoading = true
            viewModel.createPermissions(name: nameText, canRead: canRead, canWrite: canWrite, canModify: canModify, admin: admin) { status in
                self.isLoading = false
                if status { self.reloadPermissions() }
            }
        }, title: "Agregar set de permisos", isLoading: $isLoading)
        .onChange(of: viewModel.dismissView, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

#Preview {
    AddPermissionsView(reloadPermissions: {})
}
