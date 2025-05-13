import UIKit

public extension UIButton {
    convenience init(_ options: Option...) {
        self.init(options)
    }
    
    convenience init(_ options: [Option]) {
        self.init(type: .system)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case title(String?, UIControl.State)
        case titleColor(UIColor, UIControl.State)
        case tintColor(UIColor)
        case titleFont(UIFont)
        case attributedTitle(NSAttributedString, UIControl.State)
        case isHidden(Bool)
        case isEnabled(Bool)
        case image(UIImage?, UIControl.State)
        case backgroundImage(UIImage?, UIControl.State)
        case adjustsImageWhenHighlighted(Bool)
        case adjustsImageWhenDisabled(Bool)
        case contentInsets(UIEdgeInsets)
        case titleInsets(UIEdgeInsets)
        case imageInsets(UIEdgeInsets)
        case semanticContentAttribute(UISemanticContentAttribute)
        case cornerRadius(CGFloat, clipsToBound: Bool)
        case viewOption(UIView.Option)
        
        public static func title(_ string: String?) -> Self { .title(string, .normal) }
        public static func titleColor(_ color: UIColor) -> Self { .titleColor(color, .normal) }
        public static func attributedTitle(_ title: NSAttributedString) -> Self { .attributedTitle(title, .normal) }
        public static func image(_ image: UIImage?) -> Self { .image(image, .normal) }
        public static func backgroundImage(_ image: UIImage?) -> Self { .backgroundImage(image, .normal) }
        public static func cornerRadius(_ radius: CGFloat) -> Self { cornerRadius(radius, clipsToBound: true) }
        public static func height(_ value: CGFloat) -> Self { .viewOption(.height(value)) }
        public static func size(_ value: CGSize) -> Self { .viewOption(.size(value)) }
        public static var hidden: Self { .isHidden(true) }
        public static var disabled: Self { .isEnabled(false) }
        
        func apply(to button: UIButton) {
            switch self {
            case let .title(title, state): button.setTitle(title, for: state)
            case let .titleColor(color, state): button.setTitleColor(color, for: state)
            case .tintColor(let color): button.tintColor = color
            case .titleFont(let font): button.titleLabel!.font = font
            case .attributedTitle(let title, let state): button.setAttributedTitle(title, for: state)
            case .isHidden(let isHidden): button.isHidden = isHidden
            case .isEnabled(let isEnabled): button.isEnabled = isEnabled
            case let .image(image, state): button.setImage(image, for: state)
            case let .backgroundImage(image, state): button.setBackgroundImage(image, for: state)
            case .adjustsImageWhenHighlighted(let value): button.adjustsImageWhenHighlighted = value
            case .adjustsImageWhenDisabled(let value): button.adjustsImageWhenDisabled = value
            case .contentInsets(let insets): button.contentEdgeInsets = insets
            case .titleInsets(let insets): button.titleEdgeInsets = insets
            case .imageInsets(let insets): button.imageEdgeInsets = insets
            case .semanticContentAttribute(let attribute): button.semanticContentAttribute = attribute
            case let .cornerRadius(radius, clipsToBound: clipsToBounds):
                button.roundCorners(radius: radius, clipsToBounds: clipsToBounds)
            case .viewOption(let option): option.apply(to: button)
            }
        }
    }
}
