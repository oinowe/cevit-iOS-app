//
//  AddClientView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 16/04/24.
//

import SwiftUI

struct AddClientView: View {
    
    // MARK: Vars
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddClientViewModel()
    @State private var nameText: String = ""
    @State private var addressText: String = ""
    @State private var rfcText: String = ""
    @State private var cityText: String = ""
    @State private var stateText: String = ""
    @State private var isLoading: Bool = false
    var reloadClients: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Agregar nuevo cliente")
            
            TextField("Nombre", text: $nameText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Dirección", text: $addressText)
                .textFieldStyle(.roundedBorder)
            
            TextField("RFC", text: $rfcText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Ciudad", text: $cityText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Estado", text: $stateText)
                .textFieldStyle(.roundedBorder)
            
            Picker("Subscripción: ", selection: $viewModel.selectedSubscription) {
                ForEach(viewModel.subscriptions, id: \.self) {
                    Text("\($0.name) - \($0.price.clean)")
                }
            }
            .pickerStyle(.wheel)
            
            OnboardingContinueButton(action: {
                
                guard let subscription = self.viewModel.selectedSubscription else { return }
                
                self.isLoading = true
                viewModel.createClient(name: self.nameText, address: self.addressText, rfc: self.rfcText, city: self.cityText, state: self.stateText, subscriptionId: subscription.id) { status in
                    self.isLoading = false
                    if status { self.reloadClients() }
                }
            }, title: "Agregar cliente", isLoading: $isLoading)
            
            Spacer()
        }
        .padding(12)
        .onChange(of: viewModel.dismissView, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

#Preview {
    AddClientView(reloadClients: {})
}
