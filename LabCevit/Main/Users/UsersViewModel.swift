//
//  UsersViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import Foundation


// MARK: Model
struct UsersResponse: Codable {
    let success: Bool
    let users: [UsersModel]
}


struct UsersModel: Codable, Identifiable, Hashable {
    let id: String
    let client_id: Int?
    let name: String
    let last_name: String
    let email: String
    let phone_number: String
    let permissions: String?
    let type: String
    let external: Int
}


// MARK: Class

class UsersViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var users: [UsersModel] = []
    
    
    private var service = ApiServices()
    
    init() {
        
    }
    
    
    func fetchUsersByClientId(clientId: Int) {
        service.getUsersByClientId(clientId: clientId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.isLoading = false
                    self?.users = users
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
