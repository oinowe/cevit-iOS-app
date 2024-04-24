//
//  MachineSpecsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 23/04/24.
//

import Foundation

// MARK: Model
struct MachineSpecsResponse: Codable {
    let success: Bool
    let machines: [MachineSpecsModel]
}


struct MachineSpecsModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let serial_number: String
}


class MachineSpecsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var machineSpecs: [MachineSpecsModel] = []
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    
    init() {
        fetchMachineSpecs()
    }
    
    
    func fetchMachineSpecs() {
        service.getMachineSpecs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let machineSpecs):
                    self?.isLoading = false
                    self?.machineSpecs = machineSpecs
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
