import UIKit

public extension UIStackView {
    convenience init(_ options: Option...) {
        self.init(frame: .identity)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case axis(NSLayoutConstraint.Axis)
        case distribution(Distribution)
        case alignment(Alignment)
        case spacing(CGFloat)
        case customSpacing(CGFloat, after: UIView)
        case isLayoutMarginsRelativeArrangement(Bool)
        case insetsLayoutMarginsFromSafeArea(Bool)
        case subviews([UIView])
        case compound([Option])
        case viewOption(UIView.Option)
        
        public static var vertical: Self { .axis(.vertical) }
        public static var horizontal: Self { .axis(.horizontal) }
        public static func subviews(_ subviews: UIView...) -> Self { .subviews(subviews) }
        public static func alpha(_ value: CGFloat) -> Self { .viewOption(.alpha(value)) }
        
        public static func layoutMargins(_ value: UIEdgeInsets, isRelative: Bool = true) -> Self {
            .compound([.viewOption(.layoutMargins(value)), .isLayoutMarginsRelativeArrangement(isRelative)])
        }
        
        public func apply(to stack: UIStackView) {
            switch self {
            case .axis(let axis): stack.axis = axis
            case .distribution(let distribution): stack.distribution = distribution
            case .alignment(let alignment): stack.alignment = alignment
            case .spacing(let spacing): stack.spacing = spacing
            case .customSpacing(let spacing, after: let subview): stack.setCustomSpacing(spacing, after: subview)
            case .isLayoutMarginsRelativeArrangement(let value): stack.isLayoutMarginsRelativeArrangement = value
            case .insetsLayoutMarginsFromSafeArea(let value): stack.insetsLayoutMarginsFromSafeArea = value
            case .subviews(let subviews): stack.addArrangedSubviews(subviews)
            case .compound(let options): options.forEach { stack.apply(options: $0) }
            case .viewOption(let option): stack.apply(options: option)
            }
        }
    }    
}
