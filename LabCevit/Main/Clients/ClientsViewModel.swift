//
//  ClientsModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 16/04/24.
//

import Foundation
import SwiftUI

// MARK: Model
struct ClientResponse: Codable {
    let success: Bool
    let clients: [ClientModel]
}


struct ClientModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let address: String?
    let rfc: String?
    let city: String?
    let state: String?
    let subscription: String
    let is_active: Int
    let created_at: String
    let updated_at: String
}



// MARK: ViewModel
class ClientsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var clients: [ClientModel] = []
    
    private var service = ApiServices()
    
    init() {
        fetchClients()
    }
    
    
    func fetchClients() {
        service.getClients { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self?.isLoading = false
                    self?.clients = clients
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
