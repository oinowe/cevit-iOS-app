//
//  SubscriptionsViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 22/04/24.
//

import Foundation


// MARK: ViewModel
class SubscriptionsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var subscriptions: [SubscriptionsModel] = []
    
    private var service = ApiServices()
    
    
    init() {
        fetchSubscriptions()
    }
    
    
    func fetchSubscriptions() {
        service.getSubscriptions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let clients):
                    self?.isLoading = false
                    self?.subscriptions = clients
                case .failure(let error):
                    print(error)
                    self?.isLoading = false
                }
            }
        }
    }
    
    
    func deleteSubscription(atOffsets: IndexSet) {
        self.subscriptions.remove(atOffsets: atOffsets)
        // TODO: Delete from api service, add service
    }
}
