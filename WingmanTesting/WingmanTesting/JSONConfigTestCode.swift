/// ORIGINAL CODE HAS BEEN COPIED TO CLIPBOARD
func encodeCodableFile(_ file: CodableFile) -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(file)
}
func decodeCodableFile(_ data: Data) -> CodableFile? {
    let decoder = JSONDecoder()
    return try? decoder.decode(CodableFile.self, from: data)
}
// Test code
let codableFile = CodableFile()
if let data = encodeCodableFile(codableFile) {
    if let decodedFile = decodeCodableFile(data) {
        assert(codableFile == decodedFile, "Decoded file is not equal to original file")
    }
}
