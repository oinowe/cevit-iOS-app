//
//  AddSubscriptionView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    @StateObject var viewModel = AddSubscriptionViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var nameText: String = ""
    @State private var samplesPerYearText: String = ""
    @State private var allowedParameters: String = ""
    @State private var price: String = ""
    @State private var isLoading: Bool = false
    var reloadSubs: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Agregar nueva subscripción")
            
            TextField("Nombre", text: $nameText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Muestras por año", text: $samplesPerYearText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Parametros permitidos", text: $allowedParameters)
                .textFieldStyle(.roundedBorder)
            
            TextField("Precio", text: $price)
                .textFieldStyle(.roundedBorder)
            
            
            OnboardingContinueButton(action: {
                
                self.isLoading = true
                viewModel.createSubscription(name: self.nameText, samplesPerYear: self.samplesPerYearText, allowedParameters: self.allowedParameters, price: self.price) { status in
                    self.isLoading = false
                    if status { self.reloadSubs() }
                }
            }, title: "Agregar subscripción", isLoading: $isLoading)
            
            Spacer()
        }
        .padding(12)
        .onChange(of: viewModel.dismissView, perform: { _ in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

#Preview {
    AddSubscriptionView(reloadSubs: {})
}
