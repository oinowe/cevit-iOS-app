//
//  TabBarViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation

// MARK: Model
struct UserDataPermissionsResponse: Codable {
    let success: Bool
    let permissions: UserDataPermissionsModel
}


struct UserDataPermissionsModel: Codable, Identifiable, Hashable {
    let id: String
    let type: String
    let permission_name: String
    let can_read: Int
    let can_modify: Int
    let admin: Int
}


class TabBarViewModel: ObservableObject {
    
    // TODO: Check data of user
    @Published var activateAdminTab = false
    
    private var services = ApiServices()
    
    init() {
        fetchGeneralDataOfUser()
    }
    
    
    func fetchGeneralDataOfUser() {
        services.getUserPermissions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let permissions):
                    print("Admin permissions: \(permissions.admin)")
                    self?.activateAdminTab = permissions.admin == 1 ? true : false
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
