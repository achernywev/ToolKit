import Foundation

public extension Error {
    func toCodableParams() -> [String: Any] {
        return (self as NSError).toCodableParams()
    }
}

public extension NSError {
    func toCodableParams() -> [String: Any] {
        return [
            "code": code,
            "domain": domain
        ].insertingKeyValues(from: userInfo.codableRepresentation())
    }
}
