//
//  ApiServices.swift
//  LabCevit
//
//  Created by Oscar Inowe on 16/04/24.
//

import Foundation
import Amplify
import AWSPluginsCore
import Alamofire

struct ApiServices {
    private let baseURL = AWSSecrets.shared.mainBaseURL
    private let apiKey = AWSSecrets.shared.apiKey
    
    
    // MARK: Client methods
    func getClients(completion: @escaping (Result<[ClientModel], Error>) -> Void) {
        let url = "\(baseURL)/client"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: ClientResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.clients))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createClient(clientModel: CreateClientModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/client"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", clientModel)

        AF.request(url, method: .post, parameters: clientModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: Subscriptions
    func createSubscription(subscriptionModel: CreateSubscriptionModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/subscriptions"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", subscriptionModel)

        AF.request(url, method: .post, parameters: subscriptionModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getSubscriptions(completion: @escaping (Result<[SubscriptionsModel], Error>) -> Void) {
        let url = "\(baseURL)/subscriptions"
        
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: SubscriptionsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.subscriptions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    private func getAccessToken(completion: @escaping(String) -> ()) {
        
    }
}


struct GenericResponse: Codable {
    let message: String
}
