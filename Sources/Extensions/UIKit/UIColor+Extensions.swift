import Foundation

public extension UIColor {
    convenience init(dark: UIColor, light: UIColor) {
        self.init(dynamicProvider: {
            if $0.userInterfaceStyle == .dark { return dark }
            else { return light }
        })
    }
    
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}
