//
//  AddMachineSpecsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import SwiftUI

struct AddMachineSpecsView: View {
    
    // MARK: Vars
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddMachineSpecsViewModel()
    @State private var nameText: String = ""
    @State private var serialNumberText: String = ""
    @State private var isLoading: Bool = false
    var reloadMachineSpecs: () -> Void
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nueva máquina")
                
                TextField("Nombre de máquina", text: $nameText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Número de serie", text: $serialNumberText)
                    .textFieldStyle(.roundedBorder)
                
                OnboardingContinueButton(action: {
                
                    self.isLoading = true
                    viewModel.createMachineSpecs(nameText: nameText, serialNumber: serialNumberText) { status in
                        self.isLoading = false
                        if status { self.reloadMachineSpecs() }
                    }
                }, title: "Agregar máquina", isLoading: $isLoading)
                
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
    AddMachineSpecsView(reloadMachineSpecs: {})
}
