//
//  AddPermissionsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import Foundation

struct CreatePermissionsModel: Codable {
    var name: String
    var can_read: Bool
    var can_write: Bool
    var can_modify: Bool
    var admin: Bool
}


class AddPermissionsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    
    init() {
        
    }
    
    
    func createPermissions(name: String, canRead: Bool, canWrite: Bool, canModify: Bool, admin: Bool, completion: @escaping (Bool) -> Void) {
        let createPermissionModel = CreatePermissionsModel(name: name, can_read: canRead, can_write: canWrite, can_modify: canModify, admin: admin)
        
        
        service.createPermission(permissionModel: createPermissionModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.dismissView = true
                    print("Permissions created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
