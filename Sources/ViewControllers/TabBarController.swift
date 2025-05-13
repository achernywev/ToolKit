import UIKit

open class TabBarController: UITabBarController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let responsibleVC else { return super.supportedInterfaceOrientations }
        return responsibleVC.supportedInterfaceOrientations
    }
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        guard let responsibleVC else { return super.preferredStatusBarStyle }
        return responsibleVC.preferredStatusBarStyle
    }
    
    private var responsibleVC: UIViewController? {
         return presentedViewController ?? selectedViewController
    }
}
