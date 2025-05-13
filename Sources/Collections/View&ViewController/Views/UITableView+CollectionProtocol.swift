import UIKit

extension UITableView: CollectionProtocol {
    public var visibleIndexPaths: [IndexPath]? {
        return indexPathsForVisibleRows
    }
    
    public func cellForIndexPath(_ indexPath: IndexPath) -> UIView? {
        return self.cellForRow(at: indexPath)
    }
    
    public func registerCell(forItem item: any Reusable) {
        if let nib = UINib(class: item.viewClass) {
            register(nib, forCellReuseIdentifier: item.reuseIdentifier)
        } else {
            register(item.viewClass, forCellReuseIdentifier: item.reuseIdentifier)
        }
    }
    
    public func registerHeader(forItem item: any Reusable) {
        registerHeaderFooterForItem(item)
    }
    
    public func registerFooter(forItem item: any Reusable) {
        registerHeaderFooterForItem(item)
    }
    
    public func dequeueReusableCell(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
    }
    
    public func dequeueReusableHeaderView(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueHeaderFooterViewForItem(item, atIndexPath: indexPath)
    }
    
    public func dequeueReusableFooterView(forItem item: any Reusable, for indexPath: IndexPath) -> UIView {
        return dequeueHeaderFooterViewForItem(item, atIndexPath: indexPath)
    }
    
    private func registerHeaderFooterForItem(_ item: Reusable) {
        if let nib = UINib(class: item.viewClass) {
            register(nib, forHeaderFooterViewReuseIdentifier: item.reuseIdentifier)
        } else {
            register(item.viewClass, forHeaderFooterViewReuseIdentifier: item.reuseIdentifier)
        }
    }
    
    private func dequeueHeaderFooterViewForItem(_ item: Reusable, atIndexPath indexPath: IndexPath) -> UITableViewHeaderFooterView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: item.reuseIdentifier) else {
            let typeOfItem = type(of: item)
            preconditionFailure("HeaderFooterView for item: \(typeOfItem) not found")
        }
        return view
    }
}
