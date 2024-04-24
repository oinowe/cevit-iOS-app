//
//  AddMachineUnitsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation

struct CreateMachineUnitsModel: Codable {
    var machine_id: Int
    var name: String
    var unit: String
    var description: String
}



class AddMachineUnitsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    init() {
        
    }
    
    
    func createMachineUnits(machine_id: Int, name: String, unit: String, description: String, completion: @escaping (Bool) -> Void) {
        
        let createMachineUnitsModel = CreateMachineUnitsModel(machine_id: machine_id, name: name, unit: unit, description: description)
        
        
        service.createMachineUnit(createMachineUnitModel: createMachineUnitsModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.dismissView = true
                    print("Machine Unit created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
