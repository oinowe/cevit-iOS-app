//
//  AWSSecrets.swift
//  LabCevit
//
//  Created by Oscar Inowe on 16/04/24.
//

import Foundation

class AWSSecrets {
    
    static let shared = AWSSecrets()
    
//    var environment: EnvironmentVars
    
    
    init() {
//        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
//        environment = EnvironmentVars(rawValue: currentConfiguration)!
    }
    
    
    var mainBaseURL: String {
//        switch environment {
//        case .debugDevelopment, .releaseDevelopment:
//            return "blaber-introductory-audio-bucket-dev"
//        case .debugProduction, .releaseProduction:
//            return "blaber-introductory-audio-bucket-prod"
//        }
        return "http://localhost:8080"
    }
    
    
    var apiKey: String {
//        switch environment {
//        case .debugDevelopment, .releaseDevelopment:
//            return "blaber-introductory-audio-bucket-dev"
//        case .debugProduction, .releaseProduction:
//            return "blaber-introductory-audio-bucket-prod"
//        }
        return "0374f028-a23f-4d33-bc62-b28cfd9939b8"
    }
    
}


enum EnvironmentVars: String {
    case debugDevelopment = "Debug Development"
    case releaseDevelopment = "Release Development"

    case debugProduction = "Debug Production"
    case releaseProduction = "Release Production"
}
