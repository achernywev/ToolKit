import Foundation

public extension Sequence {
    func sumWithMapping<T: Numeric>(_ mapping: (Element) -> T) -> T {
        var result: T = 0
        
        for element in self {
            result += mapping(element)
        }
        
        return result
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

// MARK: - CompactMap + Join
public extension Sequence {
    func compactMap() -> Array<Element.Wrapped> where Element: OptionalValue {
        compactMap { $0.optional }
    }
    
    func joinNonNil(separator: String = "") -> String where Element == String? {
        compactMap().joined(separator: separator)
    }
    
    func joinNonEmpty(separator: String = "") -> String where Element == String? {
        return compactMap {
            guard $0?.isNotEmpty == true else { return nil }
            return $0
        }.joined(separator: separator)
    }
}
