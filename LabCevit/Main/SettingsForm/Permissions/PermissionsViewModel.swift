//
//  PermissionsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import Foundation


// MARK: Model
struct PermissionsResponse: Codable {
    let success: Bool
    let permissions: [PermissionsModel]
}


struct PermissionsModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let can_read: Int
    let can_write: Int
    let can_modify: Int
    let admin: Int
}


class PermissionsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var permissions: [PermissionsModel] = []
    
    private var service = ApiServices()
    
    init() {
        fetchPermissions()
    }
    
    
    func fetchPermissions() {
        service.getPermissions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let permissions):
                    self?.isLoading = false
                    self?.permissions = permissions
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
