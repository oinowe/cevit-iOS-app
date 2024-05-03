//
//  MachineUnitsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation

// MARK: Model
struct MachineUnitsResponse: Codable {
    let success: Bool
    let sample_units: [MachineUnitsModel]
}


struct MachineUnitsModel: Codable, Identifiable, Hashable {
    let id: Int
    let machine_id: Int
    let name: String
    let unit: String
    let subscription_id: String
    let is_id: Int
    let file_column_position: Int
    let description: String
    let subscription_names: String
}


class MachineUnitsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var machineUnits: [MachineUnitsModel] = []
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    
    init() {
        
    }
    
    
    func fetchMachineUnits(machineId: Int) {
        service.getMachineUnits(machineId: machineId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let machineUnits):
                    self?.isLoading = false
                    self?.machineUnits = machineUnits
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
