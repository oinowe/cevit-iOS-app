//
//  PermissionsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct PermissionsView: View {
    
    @StateObject var viewModel = PermissionsViewModel()
    @State private var isAddingPermissionsView = false
    
    var body: some View {
        
//        NavigationLink(destination: AddSubscriptionView(reloadSubs: reloadSubs ), isActive: $isAddingSubscriptionView) {
//            EmptyView()
//        }
//        .hidden()
        
        List {
            ForEach(viewModel.permissions, id: \.self) { perm in
                HStack {
                    VStack(alignment: .leading) {
                        Text(perm.name)
                            .bold()
                            .font(.system(size: 20))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image(systemName: "lock.square.stack.fill")
                            .foregroundColor(.accentCol)
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.inset)
        .navigationTitle("Permisos")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingPermissionsView = true }) {
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
    
    
    func reloadPermissions() {
//        viewModel.fetchSubscriptions()
    }
}

#Preview {
    PermissionsView()
}
