import Foundation

public extension Equatable {
    func isOneOf(_ values: Self...) -> Bool {
        return isOneOf(values)
    }
    
    func isOneOf(_ values: [Self]) -> Bool {
        return values.contains { $0 == self }
    }
    
    func isNotOneOf(_ values: Self...) -> Bool  {
        return isNotOneOf(values)
    }
    
    func isNotOneOf(_ values: [Self]) -> Bool {
        return values.allSatisfy { $0 != self }
    }
}
