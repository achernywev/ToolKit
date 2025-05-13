import Foundation

public protocol OptionalValue {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalValue {
    public var optional: Wrapped? { self }
}

