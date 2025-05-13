import Foundation
import UniformTypeIdentifiers

public extension URL {
    init(directory: Directory, name: String, fileType: UTType) {
        self.init(directory: directory, name: name, extension: fileType.preferredFilenameExtension)
    }
    
    init(directory: Directory, name: String, extension fileExtension: String? = nil) {
        self.init(directory: directory.url, name: name, extension: fileExtension)
    }
    
    init(directory: String, name: String, fileType: UTType) {
        self.init(directory: directory, name: name, extension: fileType.preferredFilenameExtension)
    }
    
    init(directory: String, name: String, extension fileExtension: String? = nil) {
        let directoryURL = URL(filePath: directory, directoryHint: .isDirectory)
        self.init(directory: directoryURL, name: name, extension: fileExtension)
    }
    
    init(directory: URL, name: String, fileType: UTType) {
        self.init(directory: directory, name: name, extension: fileType.preferredFilenameExtension)
    }
    
    init(directory: URL, name: String, extension fileExtension: String? = nil) {
        var url = directory
            .appendingPathComponent(name, isDirectory: false)
        if let fileExtension {
            url = url.appendingPathExtension(fileExtension)
        }
        self = url
    }
}

public extension URL {
    public struct Directory {
        public let url: URL
        
        init(path: String) {
            self.init(url: URL(filePath: path, directoryHint: .isDirectory))
        }
        
        init(url: URL) {
            self.url = url
        }
        
        public func subFolder(name: String) -> Self {
            let newURL = url.appendingPathComponent(name, isDirectory: true)
            return .init(url: newURL)
        }
        
        public func createIfNotExists() {
            let fileManager = FileManager.default
            guard !fileManager.fileExists(atPath: url.path) else { return }
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        }
        
        public static var home: Self {
            .init(path: NSHomeDirectory())
        }
        
        public static var temporary: Self {
            .init(path: NSTemporaryDirectory())
        }
        
        public static var library: Self {
            searchPathDirectory(.libraryDirectory)
        }
        
        public static var documents: Self {
            searchPathDirectory(.documentDirectory)
        }
        
        public static func searchPathDirectory(_ directory: FileManager.SearchPathDirectory) -> Self {
            let path = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first!
            return .init(path: path)
        }
    }
}
