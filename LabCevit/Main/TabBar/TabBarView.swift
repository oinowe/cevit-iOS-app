//
//  TabBarView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import SwiftUI

// Main ContentView that includes the TabView
struct TabBarView: View {
    
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView {
            ReceptionOrdersView()
                .tabItem {
                    Label("Ordenes", systemImage: "newspaper.fill")
                }
            
            if viewModel.activateAdminTab {
                ClientsView()
                    .tabItem {
                        Label("Admin", systemImage: "person.badge.shield.checkmark")
                    }
            }
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "person.fill.viewfinder")
                }
        }
    }
}



#Preview {
    TabBarView()
}
