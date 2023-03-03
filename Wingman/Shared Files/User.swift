//
//  User.swift
//  Wingman
//
//  Created by Aditya Saravana on 2/4/23.
//

import Foundation

public final class User: Codable {
    private var jsonURL = URL(fileURLWithPath: "WingmanUser", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    static var sharedInstance: User = User()
    
    private init() {}
    
    var apiKey = ""
}



public extension FileManager {
    static var documentsDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension User {
    private func loadJSON() {
        guard FileManager.default.fileExists(atPath: jsonURL.path) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: jsonURL)
            User.sharedInstance = try decoder.decode(User.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveJSON() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(User.sharedInstance)
            try data.write(to: jsonURL, options: .atomicWrite)
        } catch {
            print(error.localizedDescription)
        }
    }
}
