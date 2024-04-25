//
//  LoginModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 27/02/24.
//

import Foundation
import SwiftUI
import Amplify

class EmailLoginModel: ObservableObject {
    
    
    @Published var moveToHome = false
    @Published var moveToResetPassword = false
    @Published var isLoadingAPI: Bool = false
    
    init() {
        
    }
    
    
    func signIn(username: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
            
            switch signInResult.nextStep {
            case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
                print("SMS code send to \(deliveryDetails.destination)")
                print("Additional info \(String(describing: info))")
            case .confirmSignInWithTOTPCode:
                print("Received next step as confirm sign in with TOTP code")
            case .continueSignInWithTOTPSetup(let setUpDetails):
                print("Received next step as continue sign in by setting up TOTP")
                print("Shared secret that will be used to set up TOTP in the authenticator app \(setUpDetails.sharedSecret)")
            case .continueSignInWithMFASelection(let allowedMFATypes):
                print("Received next step as continue sign in by selecting MFA type")
                print("Allowed MFA types \(allowedMFATypes)")
            case .confirmSignInWithCustomChallenge(let info):
                print("Custom challenge, additional info \(String(describing: info))")
            case .confirmSignInWithNewPassword(let info):
                print("New password additional info \(String(describing: info))")
                DispatchQueue.main.async {
                    self.moveToResetPassword = true
                }
            case .resetPassword(let info):
                print("Reset password additional info \(String(describing: info))")
            case .confirmSignUp(let info):
                print("Confirm signup additional info \(String(describing: info))")
            case .done:
                DispatchQueue.main.async {
                    self.moveToHome = true
                }
                // Use has successfully signed in to the app
                print("Signin complete")
            }
            DispatchQueue.main.async {
                self.isLoadingAPI = false
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
            DispatchQueue.main.async {
                self.isLoadingAPI = false
            }
        } catch {
            print("Unexpected error: \(error)")
            DispatchQueue.main.async {
                self.isLoadingAPI = false
            }
        }
    }
}
