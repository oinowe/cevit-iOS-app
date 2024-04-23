//
//  ClientsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 16/04/24.
//

import SwiftUI

struct ClientsView: View {
    
    // MARK: vars
    @StateObject var viewModel = ClientsViewModel()
    @State private var isAddingPostPresented = false
    @State private var isAddingPreferences = false
    
    
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
    
            NavigationView {
                ScrollView {
                    if viewModel.isLoading {
                        LoadingSpinner()
                    } else {
                        ClientsCell(viewModel: viewModel)
                    }
                    
                    NavigationLink(destination: AddClientView(reloadClients: reloadClients), isActive: $isAddingPostPresented) {
                        EmptyView()
                    }
                    .hidden()
                    
                    
                    NavigationLink(destination: SettingsFormView(), isActive: $isAddingPreferences) {
                        EmptyView()
                    }
                    .hidden()
                }
                .navigationTitle("Clientes")
                .navigationBarItems(trailing: addButton)
                .navigationBarItems(leading: preferencesButton)
            }
        }
    }
    
    
    private var addButton: some View {
        Button(action: { isAddingPostPresented = true }) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    private var preferencesButton: some View {
        Button(action: { isAddingPreferences = true }) {
            Image(systemName: "gear.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(Color.accentCol)
        }
    }
    
    
    func reloadClients() {
        viewModel.fetchClients()
    }
}


struct ClientsCell: View {
    
    @StateObject var viewModel: ClientsViewModel
    @State private var showUsersListView = false
    @State private var isShowingUsersView = false
    
    var fontSize: CGFloat = 20.0
    
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.clients, id: \.self) { client in
                VStack {
                    HStack {
                        Text(client.name)
                            .bold()
                            .fontWeight(.heavy)
                            .font(.system(size: fontSize))
                        Spacer()
                        Text("\(client.subscription ?? 0)")
                            .font(.system(size: fontSize))
                    }
                    .padding(.horizontal, 8)
                    HStack {
                        Text(client.rfc ?? "")
                            .font(.system(size: fontSize))
                        Spacer()
                        Text("\(client.city ?? ""), \(client.state ?? "")")
                            .font(.system(size: fontSize))
                    }
                    .padding(.horizontal, 8)
                }
                .onTapGesture {
                    isShowingUsersView = true
                }
                
                
                NavigationLink(destination: UsersView(clientId: client.id), isActive: $isShowingUsersView) {
                    EmptyView()
                }
                .hidden()
                Divider()
            }
        }
    }
}


#Preview {
    ClientsView()
}
