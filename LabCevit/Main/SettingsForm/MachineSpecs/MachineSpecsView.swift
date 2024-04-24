//
//  MachineSpecsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import SwiftUI

struct MachineSpecsView: View {
    
    @StateObject var viewModel = MachineSpecsViewModel()
    @State private var isAddingMachineSpecsView = false
    
    var body: some View {
        NavigationLink(destination: AddMachineSpecsView(reloadMachineSpecs: reloadMachineSpecs), isActive: $isAddingMachineSpecsView) {
            EmptyView()
        }
        .hidden()
        
        List {
            ForEach(viewModel.machineSpecs, id: \.self) { machine in
                HStack {
                    VStack(alignment: .leading) {
                        Text(machine.name)
                            .bold()
                            .font(.system(size: 20))
                        Text(machine.serial_number)
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
        .navigationTitle("Máquinas")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingMachineSpecsView = true }) {
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
    
    
    func reloadMachineSpecs() {
        viewModel.fetchMachineSpecs()
    }
}

#Preview {
    MachineSpecsView()
}
