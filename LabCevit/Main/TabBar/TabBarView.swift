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
                    Label("Home", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
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

// Define the Profile view
struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            
            // Your content
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    TabBarView()
}
