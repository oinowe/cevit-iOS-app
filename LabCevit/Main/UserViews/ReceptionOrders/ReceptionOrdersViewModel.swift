//
//  ReceptionOrdersViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation

// MARK: Model
struct ReceptionOrdersResponse: Codable {
    let success: Bool
    let receptionOrders: [ReceptionOrdersModel]
}


struct ReceptionOrdersModel: Codable, Identifiable, Hashable {
    let id: Int
    let client_id: Int
    let client_name: String
    let file_name: String
    let number_of_samples: Int
    let price: Double
    let finished_processing: Int
    let is_deleted: Int
    let receptionOrderSamples: [ReceptionOrdersSampleModel]
}


struct ReceptionOrdersSampleModel: Codable, Identifiable, Hashable {
    let id: Int
    let wine_type: String
    let grape_type: String
    let reception_order_id: Int
    let reception_file_name: String
}



// MARK: ViewModel

class ReceptionOrdersViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var receptionOrders: [ReceptionOrdersModel] = []
    @Published var dismissView = false
    
    private var service = ApiServices()
    
    init() {
        fetchReceptionOrders()
    }
    
    
    func fetchReceptionOrders() {
        service.getReceptionOrders { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let receptionOrders):
                    self?.isLoading = false
                    self?.receptionOrders = receptionOrders
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
}
