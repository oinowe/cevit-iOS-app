//
//  AddMachineSpecsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import Foundation

// MARK: Model

struct CreateMachineSpecsModel: Codable {
    var name: String
    var serial_number: String
}


class AddMachineSpecsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    init() {
        
    }
    
    
    func createMachineSpecs(nameText: String, serialNumber: String, completion: @escaping (Bool) -> Void) {
        
        let createMachineSpecsModel = CreateMachineSpecsModel(name: nameText, serial_number: serialNumber)
        
        
        service.createMachineSpecs(createMachineSpecsModel: createMachineSpecsModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.dismissView = true
                    print("Machine Specs created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
