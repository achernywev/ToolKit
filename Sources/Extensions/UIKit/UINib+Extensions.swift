import UIKit

public extension UINib {
    convenience init?(class viewClass: UIView.Type) {
        let nibName = viewClass.className
        let bundle = Bundle(for: viewClass)
        
        guard bundle.path(forResource: nibName, ofType: "nib") != nil else { return nil }
        
        self.init(nibName: nibName, bundle: bundle)
    }
}
