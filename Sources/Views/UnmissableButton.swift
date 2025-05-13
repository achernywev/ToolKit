import UIKit

/// A `UIButton` subclass that increases the hit target size to a minimum size. This is helpful for buttons where the
/// bounds are small, and content insets aren't an appropriate mechanism for increasing the tappable area of the button.
open class UnmissableButton: UIButton {
    public var minTarget: CGSize = CGSize(width: 44, height: 44)
    public var additionalInsets: UIEdgeInsets = .zero

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let hitBounds = transformRectWithInsets(bounds)
        return hitBounds.contains(point)
    }
    
    private func transformRectWithInsets(_ rect: CGRect) -> CGRect {
        if additionalInsets == .zero {
            return rect.insetBy(dx: -max(minTarget.width - rect.width, 0) / 2,
                                dy: -max(minTarget.height - rect.height, 0) / 2)
        } else {
            var result = rect
            result.origin.x -= additionalInsets.left
            result.size.width += (additionalInsets.left + additionalInsets.right)
            result.origin.y -= additionalInsets.top
            result.size.height += (additionalInsets.top + additionalInsets.bottom)
            
            return result
        }
    }
}
