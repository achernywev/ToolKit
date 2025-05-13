import Foundation

public extension Int {
    func isValidIndexFor(itemsCount: Int) -> Bool {
        return self >= 0 && self < itemsCount
    }
}
