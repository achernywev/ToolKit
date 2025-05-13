import UIKit

public extension UITextField {
    convenience init(_ options: Option...) {
        self.init(frame: .identity)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case text(String)
        case textColor(UIColor)
        case font(UIFont)
        case placeholder(String)
        case attributedPlaceholder(NSAttributedString)
        case textAlignment(NSTextAlignment)
        case returnKeyType(UIReturnKeyType)
        case keyboardType(UIKeyboardType)
        case contentType(UITextContentType)
        case autocapitalization(UITextAutocapitalizationType)
        case delegate(UITextFieldDelegate)
        case compound([Option])
        case viewOption(UIView.Option)
        
        public static let email = compound([.keyboardType(.emailAddress), .contentType(.emailAddress), .autocapitalization(.none)])
        public static let oneTimeCode = compound([.keyboardType(.numberPad), .contentType(.oneTimeCode)])
        public static func tintColor(_ color: UIColor) -> Self { .viewOption(.tintColor(color)) }
        public static func backgroundColor(_ color: UIColor) -> Self { .viewOption(.backgroundColor(color)) }
        public static func cornerRadius(_ radius: CGFloat) -> Self { .viewOption(.cornerRadius(radius)) }
        
        public func apply(to textField: UITextField) {
            switch self {
            case .text(let text): textField.text = text
            case .textColor(let color): textField.textColor = color
            case .font(let font): textField.font = font
            case .placeholder(let text): textField.placeholder = text
            case .attributedPlaceholder(let text): textField.attributedPlaceholder = text
            case .textAlignment(let alignment): textField.textAlignment = alignment
            case .returnKeyType(let type): textField.returnKeyType = type
            case .keyboardType(let type): textField.keyboardType = type
            case .contentType(let type): textField.textContentType = type
            case .autocapitalization(let type): textField.autocapitalizationType = type
            case .delegate(let delegate): textField.delegate = delegate
            case .compound(let options): options.forEach { $0.apply(to: textField) }
            case .viewOption(let option): option.apply(to: textField)
            }
        }
    }
}
