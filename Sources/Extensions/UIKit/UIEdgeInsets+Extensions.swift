import UIKit

public extension UIEdgeInsets {
    static func hv(_ horizontal: CGFloat, _ vertical: CGFloat) -> Self {
        Self(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    static func all(_ value: CGFloat) -> Self {
        Self(top: value, left: value, bottom: value, right: value)
    }
    
    static func top(_ value: CGFloat) -> Self {
        Self(top: value, left: 0, bottom: 0, right: 0)
    }
    
    static func left(_ value: CGFloat) -> Self {
        Self(top: 0, left: value, bottom: 0, right: 0)
    }
    
    static func bottom(_ value: CGFloat) -> Self {
        Self(top: 0, left: 0, bottom: value, right: 0)
    }
    
    static func right(_ value: CGFloat) -> Self {
        Self(top: 0, left: 0, bottom: 0, right: value)
    }
    
    static func horizontal(_ value: CGFloat) -> Self {
        .hv(value, 0)
    }
    
    static func vertical(_ value: CGFloat) -> Self {
        .hv(0, value)
    }
    
    static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        Self(top: top, left: left, bottom: bottom, right: right)
    }
}
