//
//  MachineUnitsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct MachineUnitsView: View {
    
    @StateObject var viewModel = MachineUnitsViewModel()
    @State private var isAddingMachineUnitsView = false
    var machineId: Int
    var machineName: String
    
    var body: some View {
        NavigationLink(destination: AddMachineUnitsView(machineId: machineId, machineName: machineName, reloadMachineUnits: reloadMachineUnits), isActive: $isAddingMachineUnitsView) {
            EmptyView()
        }
        .hidden()
        
        List {
            ForEach(viewModel.machineUnits, id: \.self) { unit in
                HStack {
                    VStack(alignment: .leading) {
                        Text(unit.name)
                            .bold()
                            .font(.system(size: 20))
                        Text(unit.unit)
                        Text("Columna: \(unit.file_column_position)")
                        Text(unit.description)
                            .italic()
                        Text("ID Principal?: \(Image(systemName: unit.is_id == 1 ? "checkmark.circle.fill" : "xmark.circle.fill"))")
                            .foregroundColor(unit.is_id == 1 ? .green : .red)
                        Text("Subscripciones: \(unit.subscription_names)")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image(systemName: "macpro.gen2.fill")
                            .foregroundColor(.accentCol)
                    }
                }
            }
            // .onDelete(perform: delete)
        }
        .listStyle(.inset)
        .navigationTitle("Unidades de \(machineName)")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
        .onAppear {
            viewModel.fetchMachineUnits(machineId: self.machineId)
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingMachineUnitsView = true }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    func delete(at offsets: IndexSet) {
//        viewModel.deleteSubscription(atOffsets: offsets)
    }
    
    
    func reloadMachineUnits() {
        viewModel.fetchMachineUnits(machineId: machineId)
    }
}

#Preview {
    MachineUnitsView(machineId: 1, machineName: "Test")
}
