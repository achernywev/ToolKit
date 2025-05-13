import UIKit

public extension UIViewController {
    func addChildVC(_ child: UIViewController, toView: UIView? = nil, insets: UIEdgeInsets = .zero) {
        let viewToAdd: UIView = toView ?? view
        
        self.addChild(child)
        viewToAdd.addSubview(child.view)
        child.view.setupConstraints(inContainer: viewToAdd, insets: insets)
        child.didMove(toParent:self)
    }
    
    func topViewController() -> UIViewController {
        func topViewController(from rootViewController: UIViewController) -> UIViewController {
            guard let presentedViewController = rootViewController.presentedViewController else {
                return rootViewController
            }
            if let lastVC = (presentedViewController as? UINavigationController)?.viewControllers.last {
                return topViewController(from: lastVC)
            } else if let selectedVC = (presentedViewController as? UITabBarController)?.selectedViewController {
                return topViewController(from: selectedVC)
            } else {
                return topViewController(from: presentedViewController)
            }
        }
        return topViewController(from: self)
    }
}
