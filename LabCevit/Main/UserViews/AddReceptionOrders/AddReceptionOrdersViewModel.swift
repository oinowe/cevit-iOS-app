//
//  AddReceptionOrdersViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 25/04/24.
//

import Foundation

class AddReceptionOrdersViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var clients: [ClientModel] = []
    @Published var selectedClient: ClientModel?
    
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
                    self?.selectedClient = self?.clients.first
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
