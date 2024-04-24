//
//  TabBarView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import SwiftUI

// Main ContentView that includes the TabView
struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Ordenes", systemImage: "newspaper.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Info", systemImage: "person.fill.viewfinder")
                }
            
            ClientsView()
                .tabItem {
                    Label("Admin", systemImage: "person.badge.shield.checkmark")
                }
        }
    }
}

// MARK: TESTING Views
// Define the Home view
struct HomeView: View {
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Home")
                    .font(.largeTitle)
            }
        }
    }
}

// Define the Search view
struct SearchView: View {
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Search")
                    .font(.largeTitle)
            }
        }
    }
}


#Preview {
    TabBarView()
}
