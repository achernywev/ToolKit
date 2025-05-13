import Foundation

public extension DispatchQueue {
    static func runOnMainQueue(_ block: @escaping () -> Void) {
        Self.main.async(execute: block)
    }
    
    static func runOnMainQueue(after: TimeInterval, _ block: @escaping () -> Void) {
        Self.main.asyncAfter(deadline: .now() + after, execute: block)
    }
}
