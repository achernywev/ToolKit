import Foundation

public extension Array {
    mutating func append(_ elements: Element...) {
        append(contentsOf: elements)
    }
}
