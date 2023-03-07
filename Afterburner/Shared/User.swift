//
//  User.swift
//  Afterburner
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation

public final class User: Codable {
    private var jsonURL = URL(fileURLWithPath: "User", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    class var sharedInstance: User {
        struct Singleton {
            static let instance = User()
        }
        return Singleton.instance
    }
    
    private init() {
        loadJSON()
    }
    
    var data: UserData = .init(apiKey: "", maxTokens: 720) {
        didSet {
            saveJSON()
        }
    }
}

struct UserData: Codable {
    var apiKey: String
    var maxTokens: Int
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
            let jsonData = try Data(contentsOf: jsonURL)
            data = try decoder.decode(UserData.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveJSON() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: jsonURL, options: .atomicWrite)
        } catch {
            print(error.localizedDescription)
        }
    }
}
