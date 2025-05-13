import Foundation

public protocol ReusableContainerProtocol: AnyObject, Reusable {
    associatedtype Item
    var item: Item { get }
}

open class ReusableContainerItem<Item>: ReusableItem, ReusableContainerProtocol {
    public let item: Item
    
    public init(item: Item, viewClass: UIView.Type) {
        self.item = item
        super.init(viewClass: viewClass)
    }
}
