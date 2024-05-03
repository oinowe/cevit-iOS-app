//
//  AddReceptionOrdersView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 25/04/24.
//

import SwiftUI

struct AddReceptionOrdersView: View {
    
    @StateObject private var viewModel = AddReceptionOrdersViewModel()
    @State private var isLoading: Bool = false
    @State private var priceText: String = ""
    var reloadOrders: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nuevo cliente")
                
                Picker("Cliente: ", selection: $viewModel.selectedClient) {
                    ForEach(viewModel.clients, id: \.self) {
                        Text("\($0.name)")
                            .tag(($0 as ClientModel?))
                    }
                }
                .pickerStyle(.menu)
                
                
                TextField("Precio", text: $priceText)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.shipmentTrackingNumber)
                
                OnboardingContinueButton(action: {
                    
                    //guard let client = self.viewModel.selectedClient else { return }
                    
                    self.isLoading = true
                    //                viewModel.createClient(name: self.nameText, address: self.addressText, rfc: self.rfcText, city: self.cityText, state: self.stateText, subscriptionId: subscription.id) { status in
                    //                    self.isLoading = false
                    //                    if status { self.reloadClients() }
                    //                }
                }, title: "Agregar orden", isLoading: $isLoading)
                
                Spacer()
            }
        }
        .navigationTitle("Nueva orden")
    }
}

#Preview {
    AddReceptionOrdersView(reloadOrders: {})
}
