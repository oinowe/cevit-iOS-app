//
//  AddUsersViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import Foundation

// MARK: Model

struct CreateUserModel: Codable {
    var id: String
    var client_id: Int
    var name: String
    var last_name: String
    var email: String
    var phone_number: String
    var type: String
    var external: Bool
    var permissions: Int
    var temporary_password: String
}


// MARK: View Model

class AddUsersViewModel: ObservableObject {
    
    @Published var user: [UsersModel] = []
    @Published var isLoading = true
    @Published var selectedPermission: PermissionsModel?
    @Published var permissions: [PermissionsModel] = []
    @Published var dismissView = false
    
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
                    self?.selectedPermission = self?.permissions.first
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
    
    
    func createUser(clientId: Int, name: String, lastName: String, email: String, phoneNumber: String, type: String, external: Bool, permissionsId: Int, temporaryPassword: String, completion: @escaping (Bool) -> Void) {
        

        let createUserModel = CreateUserModel(id: UUID().uuidString, client_id: clientId, name: name, last_name: lastName, email: email, phone_number: phoneNumber, type: type, external: external, permissions: permissionsId, temporary_password: temporaryPassword)
        
        
        service.createUser(userModel: createUserModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.dismissView = true
                    print("User created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
