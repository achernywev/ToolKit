import UIKit

extension UICollectionView: CollectionProtocol {
    public var visibleIndexPaths: [IndexPath]? {
        return indexPathsForVisibleItems
    }
    
    public func cellForIndexPath(_ indexPath: IndexPath) -> UIView? {
        return cellForItem(at: indexPath)
    }
    
    public func registerCell(forItem item: any Reusable) {
        if let nib = UINib(class: item.viewClass) {
            register(nib, forCellWithReuseIdentifier: item.reuseIdentifier)
        } else {
            register(item.viewClass, forCellWithReuseIdentifier: item.reuseIdentifier)
        }
    }
    
    public func registerHeader(forItem item: any Reusable) {
        registerHeaderFooterForItem(item, kind: UICollectionView.elementKindSectionHeader)
    }
    
    public func registerFooter(forItem item: any Reusable) {
        registerHeaderFooterForItem(item, kind: UICollectionView.elementKindSectionFooter)
    }
    
    public func dequeueReusableCell(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueReusableCell(withReuseIdentifier: item.reuseIdentifier, for: indexPath)
    }
    
    public func dequeueReusableHeaderView(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: item.reuseIdentifier, for: indexPath)
        
    }
    
    public func dequeueReusableFooterView(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                withReuseIdentifier: item.reuseIdentifier, for: indexPath)
    }
    
    public func insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        insertSections(sections)
    }
    
    public func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        deleteSections(sections)
    }
    
    public func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        reloadSections(sections)
    }
    
    public func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        insertItems(at: indexPaths)
    }
    
    public func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        deleteItems(at: indexPaths)
    }
    
    public func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        reloadItems(at: indexPaths)
    }
    
    public func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveItem(at: indexPath, to: newIndexPath)
    }
    
    private func registerHeaderFooterForItem(_ item: Reusable, kind: String) {
        if let nib = UINib(class: item.viewClass) {
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: item.reuseIdentifier)
        } else {
            register(item.viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: item.reuseIdentifier)
        }
    }
}
