//
//  Colors.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import Foundation
import SwiftUI

extension Color {
    static let lightColor = Color("LightColor")
    static let accentColor = Color("AccentColor")
    static let darkColor = Color("DarkMainColor")
    static let mainColor = Color("MainColor")
    static let secColor = Color("SecColor")
    static let accentCol = Color("AccentColor")
}


struct LoadingSpinner: View {
    var body: some View {
        ProgressView()
            .frame(width: 100, height: 100)
            .scaleEffect(1.5)
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
    }
}
