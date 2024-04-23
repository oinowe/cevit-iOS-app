//
//  ContentView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 19/02/24.
//

import SwiftUI
import Amplify

struct AuthenticationView: View {
    
    // MARK: Vars
    @State private var authenticateUser: Bool?
    
    
    // MARK: Body
    var body: some View {
        ZStack {
            Color.lightColor
                .edgesIgnoringSafeArea(.all)
            if let isAuthenticated = authenticateUser {
                if isAuthenticated {
                    TabBarView()
                } else {
                    SignUpView()
                }
            }
        }
        .onAppear {
            Task {
                await self.fetchCurrentAuthSession()
            }
        }
    }
    
    
    // MARK: Methods
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
            DispatchQueue.main.async {
                self.authenticateUser = session.isSignedIn
            }
        } catch {
            // Handle errors appropriately
            print("Error fetching auth session: \(error)")
            DispatchQueue.main.async {
                self.authenticateUser = false
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
