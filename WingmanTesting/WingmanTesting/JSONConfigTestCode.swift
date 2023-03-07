/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
//
//  JSONConfigTestCode.swift
//  WingmanTesting
//
//  Created by Aditya Saravana on 3/2/23.
//

import Foundation

struct CodableStruct {
    var string: String
    var int: Int
}

public extension FileManager {
    static var documentsDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension CodableStruct: Codable {
    func encode() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        
        let filePath = FileManager.documentsDirectoryURL.appendingPathComponent("data.json")
        
        try data.write(to: filePath)
    }
    
    static func decode() throws -> CodableStruct? {
        let filePath = FileManager.documentsDirectoryURL.appendingPathComponent("data.json")
        let data = try Data(contentsOf: filePath)
        let decoder = JSONDecoder()
        return try decoder.decode(CodableStruct.self, from: data)
    }
}
