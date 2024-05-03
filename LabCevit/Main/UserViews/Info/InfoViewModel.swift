//
//  InfoViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin


// MARK: Model
struct UserDataResponse: Codable {
    let success: Bool
    let data: UserDataModel
}


struct UserDataModel: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let last_name: String
    let email: String
    let phone_number: String
    let type: String
    let client_name: String
    let permission_name: String
    let samples_left: Int
}



class InfoViewModel: ObservableObject {
    
    @Published var returnToHome = false
    @Published var userData: UserDataModel?
    
    private var services = ApiServices()
    
    init() {
        fetchUserData()
    }
    
    
    func fetchUserData() {
        services.getUserData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.userData = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }

        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")
            DispatchQueue.main.async {
                self.returnToHome = true
            }
            
        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.
            
            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }

            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }

            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }
            
            DispatchQueue.main.async {
                self.returnToHome = true
            }

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }
}
