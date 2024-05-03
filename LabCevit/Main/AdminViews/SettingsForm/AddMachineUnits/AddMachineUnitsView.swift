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
    @State private var selectedSubscriptions = Set<Int>()
    @State private var unitName: String = ""
    @State private var unitAbbreviation: String = ""
    @State private var descriptionText: String = ""
    @State private var columnFileText: String = ""
    @State private var isId: Bool = false
    @State private var isLoading: Bool = false
    var machineId: Int
    var machineName: String
    var reloadMachineUnits: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nueva unidad a \(machineName)")
                    .bold()
                
                TextField("Nombre de unidad", text: $unitName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Abbreviación de unidad", text: $unitAbbreviation)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Columna de archivo", text: $columnFileText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Descripción", text: $descriptionText)
                    .textFieldStyle(.roundedBorder)
                
                Divider()
                
                Toggle(isOn: $isId) {
                    Text("Columna ID?")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentCol))
                
                Divider()
                
                HStack {
                    Text("Selecciona las subscripciones a las que pertenece:")
                    Spacer()
                }
                
                ForEach(viewModel.subscriptions, id: \.id) { sub in
                    HStack {
                        Text("\(sub.name) - $\(sub.price_per_month.clean)")
                        Spacer()
                        if selectedSubscriptions.contains(sub.id) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.accentCol)
                        }
                    }
                    .padding()
                    .background(self.selectedSubscriptions.contains(sub.id) ? Color.accentCol.opacity(0.3) : Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Ensures the border respects the corner radius
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onTapGesture {
                        self.toggleSelection(for: sub)
                    }
                }
                
                
                OnboardingContinueButton(action: {
                
                    self.isLoading = true
                    viewModel.createMachineUnits(machine_id: machineId, name: unitName, unit: unitAbbreviation, is_id: isId, selectedSubscriptions: selectedSubscriptions, fileColumnPosition: Int(self.columnFileText) ?? 0, description: descriptionText) { status in
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
    
    
    func toggleSelection(for sub: SubscriptionsModel) {
        if selectedSubscriptions.contains(sub.id) {
            selectedSubscriptions.remove(sub.id)
        } else {
            selectedSubscriptions.insert(sub.id)
        }
    }
}

#Preview {
    AddMachineUnitsView(machineId: 1, machineName: "Test", reloadMachineUnits: {})
}
