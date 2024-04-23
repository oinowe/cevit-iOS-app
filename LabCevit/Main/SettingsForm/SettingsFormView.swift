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
                    // TODO: Change for new one
                    ClientsView()
                } label: {
                    Label {
                        Text("Especificaciones")
                    } icon: {
                        Image(systemName: "macpro.gen2.fill")
                    }
                }
                
                NavigationLink {
                    // TODO: Change for correct one
                    ClientsView()
                } label: {
                    Label {
                        Text("Unidades de muestreo")
                    } icon: {
                        Image(systemName: "book.pages.fill")
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
