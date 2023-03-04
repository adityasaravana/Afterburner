/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
import Foundation

struct CodableStruct: Codable {
    var string: String
    var int: Int
}

// Write code to encode and decode CodableStruct as a JSON file
// Encoding
let encoder = JSONEncoder()
let codableStruct = CodableStruct(string: "Hello World", int: 42)
if let encoded = try? encoder.encode(codableStruct) {
    // write encoded data to file
    try encoded.write(to: URL(fileURLWithPath: "codableStruct.json"))
}
// Decoding
let decoder = JSONDecoder()
if let data = try? Data(contentsOf: URL(fileURLWithPath: "codableStruct.json")), let decoded = try? decoder.decode(CodableStruct.self, from: data) {
    print(decoded.string)
    print(decoded.int)
}
