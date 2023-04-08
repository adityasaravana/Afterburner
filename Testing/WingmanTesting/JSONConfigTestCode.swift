// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
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
    // add functions to this extension to encode and decode CodableStruct as a json file to FileManager.documentsDirectoryURL
}
// Use this extension to encode the CodableStruct to a json
extension CodableStruct {
    func encode() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let url = FileManager.documentsDirectoryURL.appendingPathComponent("codable.json")
            try data.write(to: url)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
}
// Use this extension to decode the CodableStruct from a json
extension CodableStruct {
    static func decode() -> CodableStruct? {
        let decoder = JSONDecoder()
        do {
            let url = FileManager.documentsDirectoryURL.appendingPathComponent("codable.json")
            let data = try Data(contentsOf: url)
            let decoded = try decoder.decode(CodableStruct.self, from: data)
            return decoded
        } catch {
            print("Error decoding data: \(error)")
            return nil
        }
    }
}
