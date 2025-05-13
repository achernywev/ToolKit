import Foundation

open class SingleSectionDataSource: Section, BaseViewPresenterProtocol, CollectionDataSource {
    public weak var view: BaseViewProtocol?
    public var coordinator: CoordinatorProtocol?
    public var collectionView: CollectionHolderProtocol? {
        view as? CollectionHolderProtocol
    }
    
    open override func updateItem(at index: Int, using updater: ((inout Reusable) -> Void))  {
        super.updateItem(at: index, using: updater)
        collectionView?.reloadCellsStatically(indexPaths: [IndexPath(item: index, section: 0)])
    }
    
    // MARK: - CollectionDataSource
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return numberOfItems()
    }
    
    public func headerItemInSection(_ section: Int) -> Reusable? {
        return headerItem
    }
    
    public func footerItemInSection(_ section: Int) -> Reusable? {
        return footerItem
    }
    
    public func itemAtIndexPath(_ indexPath: IndexPath) -> Reusable? {
        guard isValidIndexPath(indexPath) else { return nil }
        return itemAtIndex(indexPath.row)
    }
}
