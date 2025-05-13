import Foundation

public extension CollectionHolderProtocol {
    func reloadVisibleCellsStatically() {
        guard let indexPaths = collection?.visibleIndexPaths else { return }
        reloadCellsStatically(indexPaths: indexPaths)
    }
    
    func reloadCellsStatically(indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let cell = collection?.cellForIndexPath(indexPath) as? Configurable else { continue }
            let item = collectionDataSource.itemAtIndexPath(indexPath)
            cell.configureForItem(item as Any)
        }
    }
}
