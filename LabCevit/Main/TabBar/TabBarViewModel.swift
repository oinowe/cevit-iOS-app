//
//  TabBarViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation

class TabBarViewModel: ObservableObject {
    
    // TODO: Check data of user
    @Published var activateAdminTab = true
    
    
    init() {
        fetchGeneralDataOfUser()
    }
    
    
    func fetchGeneralDataOfUser() {
        
    }
}
