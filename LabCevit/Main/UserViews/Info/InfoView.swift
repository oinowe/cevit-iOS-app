//
//  InfoView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import SwiftUI

struct InfoView: View {
    
    @StateObject private var viewModel = InfoViewModel()
    
    var body: some View {
        ZStack {
            Color.lightColor.edgesIgnoringSafeArea(.all)
            Button(action: {
                Task {
                    await viewModel.signOutLocally()
                }
            }, label: {
                Text("Logout")
            })
        }
        .fullScreenCover(isPresented: $viewModel.returnToHome, content: {
            SignUpView()
        })
    }
}

#Preview {
    InfoView()
}
