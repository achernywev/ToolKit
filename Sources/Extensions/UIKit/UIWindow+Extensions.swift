import UIKit

public extension UIWindow {
    static func createKeyAndVisible(userInterfaceStyle: UIUserInterfaceStyle, frame: CGRect = UIScreen.main.bounds,
                                    background: UIColor = .systemBackground) -> UIWindow {
        let window = UIWindow(frame: frame)
        window.overrideUserInterfaceStyle = userInterfaceStyle
        window.backgroundColor = background
        window.makeKeyAndVisible()
        return window
    }
}
