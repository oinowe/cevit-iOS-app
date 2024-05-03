//
//  AddClientViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 17/04/24.
//

import Foundation
import SwiftUI

// MARK: Model
struct SubscriptionsResponse: Codable {
    let success: Bool
    let subscriptions: [SubscriptionsModel]
}


struct SubscriptionsModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let samples_per_year: Int
    let price_per_month: Double
}


struct CreateClientModel: Codable {
    var intern_id: String
    var name: String
    var address: String
    var rfc: String
    var city: String
    var state: String
    var subscription: Int
    var sample_quantity: Int
    var is_provino: Bool
    var discount_rate: Double
}

// MARK: ViewModel

class AddClientViewModel: ObservableObject {
    
    @Published var subscriptions: [SubscriptionsModel] = []
    @Published var dismissView = false
    @Published var selectedSubscription: SubscriptionsModel?
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
                    self?.selectedSubscription = self?.subscriptions.first
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func createClient(internId: String, name: String, address: String, rfc: String, city: String, state: String, subscriptionId: Int, sampleQuantity: Int, isProvino: Bool, discountRate: Double, completion: @escaping (Bool) -> Void) {
        
        let createClientModel = CreateClientModel(intern_id: internId, name: name, address: address, rfc: rfc, city: city, state: state, subscription: subscriptionId, sample_quantity: sampleQuantity, is_provino: isProvino, discount_rate: discountRate)
        
        
        service.createClient(clientModel: createClientModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.dismissView = true
                    print("Client created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
