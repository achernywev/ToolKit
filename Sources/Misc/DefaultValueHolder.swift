import Foundation

public protocol DefaultValueHolder {
    static var defaultValue: Self { get }
}

extension Array: DefaultValueHolder {
    public static var defaultValue: Self {
        return []
    }
}

extension Dictionary: DefaultValueHolder {
    public static var defaultValue: Self {
        return [:]
    }
}

extension Optional: DefaultValueHolder {
    public static var defaultValue: Self {
        return .none
    }
}

extension Bool: DefaultValueHolder {
    public static var defaultValue: Self {
        return false
    }
}
