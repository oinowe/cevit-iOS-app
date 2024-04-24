//
//  SubscriptionsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct SubscriptionsView: View {
    
    @StateObject var viewModel = SubscriptionsViewModel()
    @State private var isAddingSubscriptionView = false
    
    var body: some View {
        
        NavigationLink(destination: AddSubscriptionView(reloadSubs: reloadSubs ), isActive: $isAddingSubscriptionView) {
            EmptyView()
        }
        .hidden()
        
        List {
            ForEach(viewModel.subscriptions, id: \.self) { sub in
                HStack {
                    VStack(alignment: .leading) {
                        Text(sub.name)
                            .bold()
                            .font(.system(size: 20))
                        Text("Precio: \(sub.price.clean)")
                        Text("Muestras por año: \(sub.samples_per_year)")
                        Text("Parametros: \(sub.allowed_parameters ?? "N/A")")
                    }
                    Spacer()
                    VStack(alignment: .trailing, content: {
                        Image(systemName: "person.circle")
                            .foregroundColor(.accentCol)
                    })
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.inset)
        .navigationTitle("Subscripciones")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingSubscriptionView = true }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    func delete(at offsets: IndexSet) {
        viewModel.deleteSubscription(atOffsets: offsets)
    }
    
    
    func reloadSubs() {
        viewModel.fetchSubscriptions()
    }
}

#Preview {
    SubscriptionsView()
}
