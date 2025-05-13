import Foundation

public struct EmptyStringValidator: StringValidatorProtocol {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ value: String?) -> String? {
        guard var value = value else { return errorMessage }
        value = value.trimmingCharacters(in: .whitespaces)
        guard value.isEmpty == false else { return errorMessage}
        return nil
    }
}

public struct DoubleStringValidator: StringValidatorProtocol {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ value: String?) -> String? {
        guard var value = value else { return errorMessage }
        value = value.trimmingCharacters(in: .whitespaces)
        guard let _ = value.doubleValue else { return errorMessage }
        return nil
    }
}

public struct RegExpValidator: StringValidatorProtocol {
    public var errorMessage: String
    public let regExp: NSRegularExpression
    
    public init?(errorMessage: String, regExp: String) {
        self.errorMessage = errorMessage
        
        if let reg =  try? NSRegularExpression(pattern: regExp, options: []) {
            self.regExp = reg
        }
        else {
            return nil
        }
    }
    
    public func validate(_ value: String?) -> String? {
        guard var value = value else { return errorMessage }
        value = value.trimmingCharacters(in: .whitespaces)
        
        let range = NSRange(location: 0, length: value.utf16.count)
        if regExp.firstMatch(in: value, options: [], range: range) != nil {
            return nil
        }
        else {
            return errorMessage
        }
    }
}
