//
//  AddMachineUnitsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct AddMachineUnitsView: View {
    
    // MARK: Vars
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddMachineUnitsViewModel()
    @State private var unitName: String = ""
    @State private var unitAbbreviation: String = ""
    @State private var descriptionText: String = ""
    @State private var isLoading: Bool = false
    var machineId: Int
    var machineName: String
    var reloadMachineUnits: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nueva unidad a \(machineName)")
                
                TextField("Nombre de unidad", text: $unitName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Abbreviación de unidad", text: $unitAbbreviation)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Descripción", text: $descriptionText)
                    .textFieldStyle(.roundedBorder)
                
                
                OnboardingContinueButton(action: {
                
                    self.isLoading = true
                    viewModel.createMachineUnits(machine_id: machineId, name: unitName, unit: unitAbbreviation, description: descriptionText) { status in
                        self.isLoading = false
                        if status { self.reloadMachineUnits() }
                    }
                }, title: "Agregar unidad", isLoading: $isLoading)
                
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
    AddMachineUnitsView(machineId: 1, machineName: "Test", reloadMachineUnits: {})
}
