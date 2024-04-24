//
//  SettingsFormView.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import SwiftUI

struct SettingsFormView: View {
    var body: some View {
        Form {
            Section {
                NavigationLink {
                    SubscriptionsView()
                } label: {
                    Label {
                        Text("Subscripciones")
                    } icon: {
                        Image(systemName: "person.circle.fill")
                    }
                }
                
                NavigationLink {
                    PermissionsView()
                } label: {
                    Label {
                        Text("Permisos")
                    } icon: {
                        Image(systemName: "lock.square.stack.fill")
                    }
                }
            } header: {
                Text("Usuarios")
            }
            

            Section {
                NavigationLink {
                    MachineSpecsView()
                } label: {
                    Label {
                        Text("Especificaciones")
                    } icon: {
                        Image(systemName: "macpro.gen2.fill")
                    }
                }
            } header: {
                Text("Máquina")
            }
        }
        .navigationTitle("Configuración")
    }
}

#Preview {
    SettingsFormView()
}
