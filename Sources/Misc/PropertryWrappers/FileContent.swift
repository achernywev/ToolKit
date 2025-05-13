import Foundation

@propertyWrapper
public class FileContent<Value: Codable> {
    public var fileExists: Bool {
        FileManager.default.fileExists(atPath: fileURL.absoluteString)
    }
    
    public var wrappedValue: Value? {
        get {
            return Value.init(url: fileURL)
        }
        set {
            try? save(content: newValue)
        }
    }
    
    public func save(content: Value?) throws {
        try content?.save(to: fileURL)
    }
    
    private let fileURL: URL
    public init(fileURL: URL) {
        self.fileURL = fileURL
    }
}
