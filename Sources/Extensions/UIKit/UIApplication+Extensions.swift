import UIKit

public extension UIApplicationDelegate {
    var topViewController: UIViewController {
        guard let window = window else {
            fatalError("topViewController UIApplicationDelegate window is nil")
        }
        guard let rootVC = window?.rootViewController else {
            fatalError("topViewController UIApplicationDelegate rootViewController is nil")
        }
        return rootVC.topViewController()
    }
}

public extension UIApplication {
    func topViewController() -> UIViewController {
        guard let window = keyWindow else {
            fatalError("topViewController UIApplication window is nil")
        }
        guard let rootVC = window.rootViewController else {
            fatalError("topViewController UIApplication rootViewController is nil")
        }
        return rootVC.topViewController()
    }
}
