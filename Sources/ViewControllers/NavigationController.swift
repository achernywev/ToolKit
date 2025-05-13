import UIKit

open class NavigationController: UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let responsibleVC else { return super.supportedInterfaceOrientations }
        return responsibleVC.supportedInterfaceOrientations
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        guard let responsibleVC else { return super.preferredStatusBarStyle }
        return responsibleVC.preferredStatusBarStyle
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    private var responsibleVC: UIViewController? {
         return presentedViewController ?? topViewController
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer && viewControllers.count == 1 {
            return false
        }
        return true
    }
}
