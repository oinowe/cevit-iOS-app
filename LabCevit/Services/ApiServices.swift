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
    
    
    // MARK: Users
    func getUsersByClientId(clientId: Int, completion: @escaping (Result<[UsersModel], Error>) -> Void) {
        let url = "\(baseURL)/user"
        
        let parameters: [String: Any] = ["clientId": clientId]
        
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: UsersResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createUser(userModel: CreateUserModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/user"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", userModel)

        AF.request(url, method: .post, parameters: userModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: Permissions
    func getPermissions(completion: @escaping (Result<[PermissionsModel], Error>) -> Void) {
        let url = "\(baseURL)/permissions"
        
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: PermissionsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.permissions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createPermission(permissionModel: CreatePermissionsModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/permissions"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", permissionModel)

        AF.request(url, method: .post, parameters: permissionModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: Machine specs
    func getMachineSpecs(completion: @escaping (Result<[MachineSpecsModel], Error>) -> Void) {
        let url = "\(baseURL)/machineSpecs"
        
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: MachineSpecsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.machines))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createMachineSpecs(createMachineSpecsModel: CreateMachineSpecsModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/machineSpecs"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", createMachineSpecsModel)

        AF.request(url, method: .post, parameters: createMachineSpecsModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Machine Units
    func getMachineUnits(machineId: Int, completion: @escaping (Result<[MachineUnitsModel], Error>) -> Void) {
        let url = "\(baseURL)/machineUnits"
        
        let parameters: [String: Any] = ["machineId": machineId]
        
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: MachineUnitsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.sample_units))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createMachineUnit(createMachineUnitModel: CreateMachineUnitsModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = "\(baseURL)/machineUnits"
        let headers: HTTPHeaders = [
            "x-api-key": "\(apiKey)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        print("params: ", createMachineUnitModel)

        AF.request(url, method: .post, parameters: createMachineUnitModel, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    // MARK: User Data
    // TODO: Change machine specsmodel to correct one, final not yet have it
    func getUserData(completion: @escaping (Result<[MachineSpecsModel], Error>) -> Void) async {
        let url = "\(baseURL)/userData"
        
        // Retrieve the access token asynchronously
        guard let token = await getAccessToken() else {
            completion(.failure(NSError(domain: "No Token", code: 0, userInfo: [NSLocalizedDescriptionKey: "Authentication token not available."])))
            return
        }
        print("Token: \(token)")

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: MachineSpecsResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.machines))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    private func getAccessToken() async -> String? {

        do {
            let session = try await Amplify.Auth.fetchAuthSession()

            // Get cognito user pool token
            if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                return tokens.accessToken
            }
        } catch let error as AuthError {
            print("Fetch auth session failed with error - \(error)")
        } catch { }
        return nil
    }
}


struct GenericResponse: Codable {
    let message: String
}
