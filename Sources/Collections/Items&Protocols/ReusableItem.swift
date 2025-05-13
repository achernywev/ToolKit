import UIKit

open class ReusableItem: Reusable {
    public let viewClass: UIView.Type
    
    public init(viewClass: UIView.Type) {
        self.viewClass = viewClass
    }
}
