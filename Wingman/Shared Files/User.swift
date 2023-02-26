//
//  User.swift
//  Wingman
//
//  Created by Aditya Saravana on 2/4/23.
//

import Foundation
import Combine

public enum WingmanStatus {
    case notRunning
    case awaitingResponse
    case error
}

public final class WingmanUser: ObservableObject {
    private let jsonURL = URL(fileURLWithPath: "WingmanUser", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    static var sharedInstance: WingmanUser = WingmanUser()
    
    private init() {}
    
    var user = User(statusCode: 0)
    
    var status: WingmanStatus {
        if user.statusCode == 0 {
            return .notRunning
        } else if user.statusCode == 1 {
            return.awaitingResponse
        } else {
            print("ERROR: ATTEMPT TO CALCULATE STATUS WITH STATUS CODE RETURNED A VALUE NOT EQUAL TO 1 OR 0")
            return .error
        }
    }
    
    var licenseKey: String = ""
    var licenseLeyValid: Bool {
        let connector = GumroadConnector()
        return connector.validateKey(licenseKey)
    }
    
    #warning("TODO")
    /// Add in-app free trial implementation
}

struct User: Codable {
    var statusCode: Int
}



public extension FileManager {
    static var documentsDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension WingmanUser {
    private func loadJSON() {
        guard FileManager.default.fileExists(atPath: jsonURL.path) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: jsonURL)
            user = try decoder.decode(User.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveJSON() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(user)
            try data.write(to: jsonURL, options: .atomicWrite)
        } catch {
            print(error.localizedDescription)
        }
    }
}
