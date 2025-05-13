import UIKit

public extension UITextView {
    convenience init(_ options: Option...) {
        self.init(options)
    }
    
    convenience init(_ options: [Option]) {
        self.init(frame: .identity)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case text(String)
        case attributedText(NSAttributedString)
        case font(UIFont)
        case textColor(UIColor)
        case textAlignment(NSTextAlignment)
        case textContainerInset(UIEdgeInsets)
        case lineFragmentPadding(CGFloat)
        case keyboardType(UIKeyboardType)
        case contentType(UITextContentType)
        case autocapitalization(UITextAutocapitalizationType)
        case isScrollEnabled(Bool)
        case isEditable(Bool)
        case delegate(UITextViewDelegate)
        case compound([Option])
        case viewOption(UIView.Option)
        case numberOfLines(Int)
        
        public static let email = compound([.keyboardType(.emailAddress), .contentType(.emailAddress), .autocapitalization(.none)])
        public static func backgroundColor(_ color: UIColor) -> Self { .viewOption(.backgroundColor(color)) }
        public static func cornerRadius(_ radius: CGFloat) -> Self { .viewOption(.cornerRadius(radius)) }
        
        public func apply(to view: UITextView) {
            switch self {
            case .text(let text): view.text = text
            case .attributedText(let text): view.attributedText = text
            case .font(let font): view.font = font
            case .textColor(let color): view.textColor = color
            case .textAlignment(let alignment): view.textAlignment = alignment
            case .textContainerInset(let inset): view.textContainerInset = inset
            case .lineFragmentPadding(let padding): view.textContainer.lineFragmentPadding = padding
            case .keyboardType(let type): view.keyboardType = type
            case .contentType(let type): view.textContentType = type
            case .autocapitalization(let type): view.autocapitalizationType = type
            case .isScrollEnabled(let isEnabled): view.isScrollEnabled = isEnabled
            case .isEditable(let isEditable): view.isEditable = isEditable
            case .delegate(let delegate): view.delegate = delegate
            case .compound(let options): options.forEach { $0.apply(to: view) }
            case .viewOption(let option): option.apply(to: view)
            case .numberOfLines(let number): view.textContainer.maximumNumberOfLines = number
            }
        }
    }
}
