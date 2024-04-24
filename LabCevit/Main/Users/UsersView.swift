//
//  UsersView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct UsersView: View {
    
    var clientId: Int
    var clientName: String
    @State private var isAddingUsersView = false
    @StateObject var viewModel = UsersViewModel()
    
    
    init(clientId: Int, clientName: String) {
        self.clientId = clientId
        self.clientName = clientName
    }
    
    var body: some View {
        
        NavigationLink(destination: AddUsersView(clientName: self.clientName, clientId: self.clientId, reloadUsers: reloadUsers), isActive: $isAddingUsersView) {
            EmptyView()
        }
        .hidden()
        
        
        List {
            ForEach(viewModel.users, id: \.self) { user in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(user.name) \(user.last_name)")
                            .bold()
                            .font(.system(size: 24))
                        Text("\(Image(systemName: "envelope")) \(user.email)")
                        Text("\(Image(systemName: "phone")) \(user.phone_number)")
                        Text("\(Image(systemName: "figure.wave")) \(user.type)")
                        Text("Permisos: \(user.permissions ?? "")")
                        Text("Externo: \(user.external)")
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.inset)
        .navigationTitle(clientName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addButton
            }
        }
        .onAppear {
            viewModel.fetchUsersByClientId(clientId: self.clientId)
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingUsersView = true }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    func delete(at offsets: IndexSet) {
        //viewModel.deleteSubscription(atOffsets: offsets)
    }
    
    
    func reloadUsers() {
        viewModel.fetchUsersByClientId(clientId: self.clientId)
    }
}

#Preview {
    UsersView(clientId: 1, clientName: "Test")
}
