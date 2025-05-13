import Foundation

public extension Hashable {
    func isOneOf(_ values: Self...) -> Bool {
        return isOneOf(values)
    }
    
    func isOneOf(_ values: [Self]) -> Bool {
        let set = Set(values)
        return isOneOf(set)
    }
    
    func isOneOf(_ values: Set<Self>) -> Bool {
        return values.contains(self)
    }
    
    func isNotOneOf(_ values: Self...) -> Bool  {
        let set = Set(values)
        return isNotOneOf(set)
    }
    
    func isNotOneOf(_ values: Set<Self>) -> Bool {
        return isOneOf(values) == false
    }
}
