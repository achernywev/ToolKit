import Foundation

public extension Dictionary {
    mutating func insertKeyValues(from dictionary: Dictionary, overwrite: Bool = true) {
        dictionary.forEach { key, value in
            if overwrite || self[key] == nil {
                self[key] = value
            }
        }
    }
    
    public func insertingKeyValues(from dictionary: Dictionary, overwrite: Bool = true) -> Dictionary {
        var copy = self
        copy.insertKeyValues(from: dictionary, overwrite: overwrite)
        return copy
    }
    
    func codableRepresentation() -> Dictionary {
        return self.filter {
            $0.value is NSError == false && $0.value is Codable
        }
    }
}
