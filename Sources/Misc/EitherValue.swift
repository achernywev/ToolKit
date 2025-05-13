import Foundation

/// Returns left value if condition is true and right if false
@propertyWrapper
open class EitherValue<Value> {
    private var left: Value
    private var right: Value
    private let conditionProvider: () -> Bool
    open var wrappedValue: Value {
        if conditionProvider() {
            return left
        } else {
            return right
        }
    }
    
    public init(left: Value, right: Value, conditionProvider: @escaping () -> Bool) {
        self.left = left
        self.right = right
        self.conditionProvider = conditionProvider
    }
    
    open func mapBoth<T>(_ transform: (Value) -> T) -> EitherValue<T> {
        let transformedLeft = transform(left)
        let transformedRight = transform(right)
        return .init(left: transformedLeft, right: transformedRight, conditionProvider: conditionProvider)
    }
    
    open func updateBoth(_ transform: (Bool, inout Value) -> Void) {
        transform(true, &left)
        transform(false, &right)
    }
}
