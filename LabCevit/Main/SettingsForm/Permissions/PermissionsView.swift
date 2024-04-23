//
//  PermissionsView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct PermissionsView: View {
    
    @StateObject var viewModel = PermissionsViewModel()
    
    var body: some View {
        Text("Permissions")
    }
}

#Preview {
    PermissionsView()
}
