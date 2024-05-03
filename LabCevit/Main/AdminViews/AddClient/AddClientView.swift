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
    @State private var internIdText: String = ""
    @State private var nameText: String = ""
    @State private var addressText: String = ""
    @State private var rfcText: String = ""
    @State private var cityText: String = ""
    @State private var stateText: String = ""
    @State private var isLoading: Bool = false
    @State private var isProvino: Bool = false
    @State private var discountRate: String = ""
    var reloadClients: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                Text("Agregar nuevo cliente")
                
                TextField("ID interno", text: $internIdText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Nombre", text: $nameText)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                
                TextField("Dirección", text: $addressText)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.fullStreetAddress)
                
                TextField("RFC", text: $rfcText)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Ciudad", text: $cityText)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.addressCity)
                
                TextField("Estado", text: $stateText)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.addressState)
                
                TextField("Descuento (opcional)", text: $discountRate)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.oneTimeCode)
                
                Picker("Subscripción: ", selection: $viewModel.selectedSubscription) {
                    ForEach(viewModel.subscriptions, id: \.self) {
                        Text("\($0.name) - \($0.price_per_month.clean)")
                            .tag(($0 as SubscriptionsModel?))
                    }
                }
                .pickerStyle(.menu)
                
                
                Toggle("Provino: ", isOn: $isProvino)
                    .padding(.horizontal, 100)
                
                
                OnboardingContinueButton(action: {
                    
                    guard let subscription = self.viewModel.selectedSubscription else { return }
                    
                    self.isLoading = true
                    viewModel.createClient(internId: self.internIdText, name: self.nameText, address: self.addressText, rfc: self.rfcText, city: self.cityText, state: self.stateText, subscriptionId: subscription.id, sampleQuantity: subscription.samples_per_year, isProvino: self.isProvino, discountRate: Double(self.discountRate) ?? 0.0) { status in
                        self.isLoading = false
                        if status { self.reloadClients() }
                    }
                }, title: "Agregar cliente", isLoading: $isLoading)
                
                Spacer()
            }
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
