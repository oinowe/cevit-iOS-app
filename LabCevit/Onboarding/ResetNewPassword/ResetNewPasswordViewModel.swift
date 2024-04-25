//
//  ResetNewPasswordViewModel.swift
//  LabCevit
//
//  Created by Oscar Inowe on 24/04/24.
//

import Foundation
import Amplify

class ResetNewPasswordViewModel: ObservableObject {
    
    @Published var moveToHome = false
    @Published var isLoadingAPI: Bool = false
    
    
    init() {
        
    }
    
    
    func changePassword(password: String) async {
        do {
            let signInResult = try await Amplify.Auth.confirmSignIn(challengeResponse: password)
            if signInResult.isSignedIn {
                print("Confirm sign in succeeded. The user is signed in.")
                DispatchQueue.main.async {
                    self.isLoadingAPI = false
                    self.moveToHome = true
                }
            } else {
                print("Confirm sign in succeeded.")
                print("Next step: \(signInResult.nextStep)")
                // Switch on the next step to take appropriate actions.
                // If `signInResult.isSignedIn` is true, the next step
                // is 'done', and the user is now signed in.
                DispatchQueue.main.async {
                    self.isLoadingAPI = false
                }
            }
        } catch let error as AuthError {
            print("Confirm sign in failed \(error)")
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
