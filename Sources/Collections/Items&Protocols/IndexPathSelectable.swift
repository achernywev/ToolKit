import Foundation

public protocol IndexPathSelectable {
    typealias SelectionHandler = (IndexPath) -> Void
    var selectionHandler: SelectionHandler? { get }
}

public extension IndexPathSelectable {
    func triggerSelection(for indexPath: IndexPath) {
        selectionHandler?(indexPath)
    }
}
