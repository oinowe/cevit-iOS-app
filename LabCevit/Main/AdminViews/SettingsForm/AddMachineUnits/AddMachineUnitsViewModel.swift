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
    var is_id: Bool
    var subscription_id: String
    var file_column_position: Int
    var description: String
}



class AddMachineUnitsViewModel: ObservableObject {
    
    @Published var subscriptions: [SubscriptionsModel] = []
    @Published var isLoading = true
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    init() {
        fetchSubscriptions()
    }
    
    
    private func fetchSubscriptions() {
        service.getSubscriptions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self?.subscriptions = clients
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func createMachineUnits(machine_id: Int, name: String, unit: String, is_id: Bool, selectedSubscriptions: Set<Int>, fileColumnPosition: Int, description: String, completion: @escaping (Bool) -> Void) {
        
        //let ids = selectedSubscriptions.map { $0.id }
        let idString = selectedSubscriptions.map(String.init).joined(separator: ",")
        
        let createMachineUnitsModel = CreateMachineUnitsModel(machine_id: machine_id, name: name, unit: unit, is_id: is_id, subscription_id: idString, file_column_position: fileColumnPosition, description: description)
        
        
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
