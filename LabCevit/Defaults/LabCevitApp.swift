//
//  LabCevitApp.swift
//  LabCevit
//
//  Created by Oscar Inowe on 19/02/24.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct LabCevitApp: App {
    
    
    // MARK: Initial methods
    init() {
        do {
            print("Amplify configured with auth plugin")
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            
            let amplifyConfig = try AmplifyConfiguration(configurationFile: getAWSJSONConfiguration())
            try Amplify.configure(amplifyConfig)
        
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
        }
    }
    
    
    // MARK: Methods
    func getAWSJSONConfiguration() -> URL {
//        var environment: EnvironmentVars
//        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
//        environment = EnvironmentVars(rawValue: currentConfiguration)!
//
//        switch environment {
//        case .debugDevelopment, .releaseDevelopment:
//            let path = Bundle.main.path(forResource: "amplifyconfiguration-dev", ofType: "json")!
//            let url = URL(fileURLWithPath: path)
//            return url
//        case .debugProduction, .releaseProduction:
//            let path = Bundle.main.path(forResource: "amplifyconfiguration", ofType: "json")!
//            let url = URL(fileURLWithPath: path)
//            return url
//        }
        let path = Bundle.main.path(forResource: "amplifyconfiguration-dev", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        return url
    }
}
