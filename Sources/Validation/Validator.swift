import Foundation

public protocol StringValidatorProtocol {
    func validate(_ value: String?) -> String?
}

public protocol ValidatableStringProtocol: Updatable {
    var validator: StringValidatorProtocol? { get set }
    var value: String { get set }
    var lastValidationError: String? { get set }
}

public extension ValidatableStringProtocol {
    func validate() -> Bool {
        lastValidationError = validator?.validate(value)
        return (lastValidationError == nil)
    }
}

extension Array: StringValidatorProtocol where Element: StringValidatorProtocol {
    public func validate(_ value: String?) -> String? {
        for item in self {
            if let result = item.validate(value) {
                return result
            }
        }
        return nil
    }
}
