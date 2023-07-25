//
//  DataManager.swift
//  Afterburner
//
//  Created by Aditya Saravana on 4/7/23.
//

import Foundation
import KeychainSwift

public struct DataManager {
    private let keychain = KeychainSwift()
    
    func push(key: Keys, content: String) {
        keychain.set(content, forKey: key.rawValue)
    }
    
    func pull(key: Keys) -> String? {
        return keychain.get(key.rawValue)
    }
    
    public enum Keys {
        case openAIKey
        
        var rawValue: String {
            switch self {
            case .openAIKey: return "Afterburner User API Key"
            }
        }
    }
}
