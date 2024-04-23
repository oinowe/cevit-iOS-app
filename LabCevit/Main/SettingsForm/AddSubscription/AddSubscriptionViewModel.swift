//
//  AddSubscriptionViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import Foundation


struct CreateSubscriptionModel: Codable {
    var name: String
    var samples_per_year: Int
    var allowed_parameters: String
    var price: Double
}


class AddSubscriptionViewModel: ObservableObject {
    
    @Published var dismissView = false
    private var service = ApiServices()
    
    init() {
        
    }
    
    
    func createSubscription(name: String, samplesPerYear: String, allowedParameters: String, price: String, completion: @escaping (Bool) -> Void) {
        
        let createSubModel = CreateSubscriptionModel(name: name, samples_per_year: Int(samplesPerYear) ?? 0, allowed_parameters: allowedParameters, price: Double(price) ?? 0.0)
        
        
        service.createSubscription(subscriptionModel: createSubModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let status):
                    self?.dismissView = true
                    print("Subscription created successfully")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    }
}
