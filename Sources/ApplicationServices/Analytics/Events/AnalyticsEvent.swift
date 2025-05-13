import Foundation


public protocol AnalyticsEventProtocol {
    typealias Properties = [String: Any]
    
    var prefix: String? { get }
    var subName: String { get }
    var customParameters: Properties? { get }
}

public extension AnalyticsEventProtocol {
    var prefix: String? { nil }
    var customParameters: Properties? { nil }
    
    private var alternativeLabel: String { "\(self)" }
    
    var trackingName: String {
        return [prefix?.snakeCased, subName.snakeCased].joinNonEmpty(separator: "_")
    }
    
    var subName: String {
        let reflection = Mirror(reflecting: self)
        guard reflection.displayStyle == .enum, let associated = reflection.children.first else {
            return alternativeLabel
        }
        return associated.label ?? alternativeLabel
    }
    
    var parameters: Properties? {
        if let customParameters {
            return customParameters
        }
        
        let reflection = Mirror(reflecting: self)
        guard reflection.displayStyle == .enum, let associated = reflection.children.first else {
            return nil
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let values = Mirror(reflecting: associated.value).children
        
        var params = Properties()
        for case let item in values {
            guard let key = item.label else { continue }
            guard let data = data(from: item.value, using: encoder) else { continue }
            let value = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            params[key] = value
        }
        return params
    }
    
    private func data(from value: Any, using encoder: JSONEncoder) -> Data? {
        let encodableData = { (from: Any) -> Data? in
            if let encodable = from as? Encodable, let data = try? encoder.encode(encodable) {
                return data
            } else {
                return nil
            }
        }
        return encodableData(value)
    }
}

private extension String {
    var snakeCased: String {
        return words.joined(separator: "_")
    }
}

private extension Array where Element == Character {
    var lowercased: String {
        return String(self).lowercased()
    }
}
