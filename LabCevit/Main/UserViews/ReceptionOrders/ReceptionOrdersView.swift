//
//  ReceptionOrdersView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct ReceptionOrdersView: View {
    
    @StateObject private var viewModel = ReceptionOrdersViewModel()
    @State private var selection: Set<ReceptionOrdersModel> = []
    @State private var isAddingReceptionOrdersView = false
    
    var body: some View {
        NavigationView {
            List(viewModel.receptionOrders) { order in
                ReceptionOrderElementView(order: order, isExpanded: self.selection.contains(order))
                    .onTapGesture { self.selectOrder(order) }
                    .animation(.linear(duration: 0.3))
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton
                }
            }
            .navigationTitle("Ordenes")
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingReceptionOrdersView = true }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    func selectOrder(_ order: ReceptionOrdersModel) {
        if selection.contains(order) {
            selection.remove(order)
        } else {
            selection.insert(order)
        }
    }
    
    
    func reloadReceptionOrders() {
        viewModel.fetchReceptionOrders()
    }
}


struct ReceptionOrderElementView: View {
    let order: ReceptionOrdersModel
    let isExpanded: Bool
    
    var body: some View {
        HStack {
            content
            Spacer()
        }
        .contentShape(Rectangle())
    }
    
    
    private var content: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Orden: \(order.file_name)")
                    .font(.headline)
                Text("Cliente: \(order.client_name)")
                Text("Número de muestras: \(order.number_of_samples)")
                Text("Precio: $\(order.price.clean)")
                Text("Status: \(order.finished_processing == 1 ? "Terminado" : "En proceso")")
                
                
                if isExpanded {
                    VStack(alignment: .leading) {
                        ForEach(order.receptionOrderSamples) { sample in
                            Text(sample.wine_type)
                        }
                    }
                }
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Image(systemName: order.finished_processing == 1 ? "checkmark.circle.fill" : "slowmo")
                    .foregroundColor(order.finished_processing == 1 ? .accentCol : .darkMain)
            }
        }
    }
}


#Preview {
    ReceptionOrdersView()
}
