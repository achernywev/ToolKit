import Foundation

public protocol SelectableItemProtocol: ReusableContainerProtocol {
    var isSelected: Bool { get set }
}

open class SelectableItem<Item>: ReusableContainerItem<Item>, SelectableItemProtocol, IndexPathSelectable {
    public var isSelected: Bool
    public let selectionHandler: SelectionHandler?
    
    public init(item: Item, isSelected: Bool = false, viewClass: UIView.Type, selectionHandler: SelectionHandler?) {
        self.isSelected = isSelected
        self.selectionHandler = selectionHandler
        super.init(item: item, viewClass: viewClass)
    }
}
