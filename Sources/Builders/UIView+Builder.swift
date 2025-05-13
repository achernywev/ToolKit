import UIKit

public extension UIView {
    convenience init(_ options: Option...) {
        self.init(frame: .identity)
        options.forEach { $0.apply(to: self) }
    }
    
    @discardableResult func apply(options: Option...) -> Self {
        options.forEach { $0.apply(to: self) }
        return self
    }
    
    public enum Option {
        case backgroundColor(UIColor)
        case subviews([UIView])
        case layoutGuides([UILayoutGuide])
        case layoutMargins(UIEdgeInsets)
        case isHidden(Bool)
        case cornerRadius(CGFloat)
        case maskedCorners(CACornerMask)
        case height(CGFloat)
        case width(CGFloat)
        case aspectRatio(CGFloat)
        case tintColor(UIColor)
        case alpha(CGFloat)
        case clipsToBounds(Bool)
        case contentMode(ContentMode)
        case transform(CGAffineTransform)
        case isUserInteractionEnabled(Bool)
        case gestureRecognizers([UIGestureRecognizer])
        case tag(Int)
        case contentHuggingPriority(UILayoutPriority, NSLayoutConstraint.Axis)
        case compound([Option])
        
        public static var hidden: Self { .isHidden(true) }
        public static func color(_ value: UIColor) -> Self { .backgroundColor(value) }
        public static func subviews(_ subviews: UIView...) -> Self { .subviews(subviews) }
        public static func layoutGuides(_ guides: UILayoutGuide...) -> Self { .layoutGuides(guides) }
        public static func size(_ value: CGSize) -> Self { .compound([.width(value.width), .height(value.height)]) }
        public static func gestureRecognizers(_ recognizers: UIGestureRecognizer...) -> Self { .gestureRecognizers(recognizers) }
        public static func corners(radius: CGFloat) -> Self { .compound([.cornerRadius(radius), .clipsToBounds(true)])}
        
        public func apply(to view: UIView) {
            switch self {
            case .backgroundColor(let color): view.backgroundColor = color
            case .subviews(let subviews): view.addSubviews(subviews)
            case .layoutGuides(let guides): view.addLayoutGuides(guides)
            case .layoutMargins(let margins): view.layoutMargins = margins
            case .isHidden(let isHidden): view.isHidden = isHidden
            case .cornerRadius(let radius): view.layer.cornerRadius = radius
            case .maskedCorners(let mask): view.layer.maskedCorners = mask
            case .height(let height): view.snp.makeConstraints { $0.height.equalTo(height) }
            case .width(let width): view.snp.makeConstraints { $0.width.equalTo(width) }
            case .aspectRatio(let ratio):
                view.snp.makeConstraints { $0.width.equalTo(view.snp.height).multipliedBy(ratio) }
            case .tintColor(let color): view.tintColor = color
            case .alpha(let alpha): view.alpha = alpha
            case .clipsToBounds(let clipsToBounds): view.clipsToBounds = clipsToBounds
            case .contentMode(let mode): view.contentMode = mode
            case .transform(let transform): view.transform = transform
            case .isUserInteractionEnabled(let isEnabled): view.isUserInteractionEnabled = isEnabled
            case .gestureRecognizers(let recognizers): recognizers.forEach { view.addGestureRecognizer($0) }
            case .tag(let tag): view.tag = tag
            case .contentHuggingPriority(let priority, let axis): view.setContentHuggingPriority(priority, for: axis)
            case .compound(let options): options.forEach { $0.apply(to: view) }
            }
        }
    }
}
