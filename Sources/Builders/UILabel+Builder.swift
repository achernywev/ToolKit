import UIKit

public extension UILabel {
    convenience init(_ options: Option...) {
        self.init(options)
    }
    
    convenience init(_ options: [Option]) {
        self.init(frame: .identity)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        apply(options: options)
    }
    
    @discardableResult func apply(options: [Option]) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case text(String)
        case minimumScaleFactor(CGFloat)
        case attributedText(NSAttributedString)
        case font(UIFont)
        case textColor(UIColor)
        case textAlignment(NSTextAlignment)
        case numberOfLines(Int)
        case adjustsFontSizeToFitWidth(Bool)
        case viewOption(UIView.Option)
        case compound([Option])
        
        public static var left: Option { .textAlignment(.left) }
        public static var right: Option { .textAlignment(.right) }
        public static var center: Option { .textAlignment(.center) }
        public static func backgroundColor(_ color: UIColor) -> Self { .viewOption(.backgroundColor(color)) }
        public static func isHidden(_ value: Bool) -> Self { .viewOption(.isHidden(value)) }
        public static func alpha(_ value: CGFloat) -> Self { .viewOption(.alpha(value)) }
        public static func size(_ value: CGSize) -> Self { .viewOption(.size(value)) }
        public static func cornerRadius(_ radius: CGFloat, clipsToBounds: Bool = true) -> Self {
            return .viewOption(.compound([.cornerRadius(radius), .clipsToBounds(clipsToBounds)]))
        }
        
        public func apply(to label: UILabel) {
            switch self {
            case .text(let text): label.text = text
            case .minimumScaleFactor(let factor): label.minimumScaleFactor = factor
            case .attributedText(let text): label.attributedText = text
            case .font(let font): label.font = font
            case .textColor(let color): label.textColor = color
            case .textAlignment(let alignment): label.textAlignment = alignment
            case .numberOfLines(let lines): label.numberOfLines = lines
            case .adjustsFontSizeToFitWidth(let value): label.adjustsFontSizeToFitWidth = value
            case .viewOption(let option): option.apply(to: label)
            case .compound(let options): label.apply(options: options)
            }
        }
    }
}
