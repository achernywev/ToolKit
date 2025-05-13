import Foundation

public extension Encodable {
    var jsonData: Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        } catch {
            let typeName = String(describing: Self.self)
            print("Error encoding \(typeName): \(error)")
            return nil
        }
    }
    
    @discardableResult
    func save(to url: URL?) -> Bool {
        guard let url else { return false }
        do {
            try save(to: url)
            return true
        } catch {
            return false
        }
    }
    
    func save(to url: URL) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let directoryUrl = url.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: directoryUrl.path) {
            try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true)
        }
        try data.write(to: url)
    }    
}
