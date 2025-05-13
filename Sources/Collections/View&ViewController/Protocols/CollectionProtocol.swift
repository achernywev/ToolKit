import UIKit

public protocol CollectionProtocol where Self: UIScrollView {
    var backgroundView: UIView? { get set }
    var visibleIndexPaths: [IndexPath]? { get }
    var refreshControl: UIRefreshControl? { get set }
    
    func reloadData()
    func cellForIndexPath(_ indexPath: IndexPath) -> UIView?
    
    func registerCell(forItem item: Reusable)
    func registerHeader(forItem item: Reusable)
    func registerFooter(forItem item: Reusable)
    func dequeueReusableCell(forItem: Reusable, for indexPath: IndexPath) -> UIView
    func dequeueReusableHeaderView(forItem: Reusable, for indexPath: IndexPath) -> UIView
    func dequeueReusableFooterView(forItem: Reusable, for indexPath: IndexPath) -> UIView
    
    func insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)
    func deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)
    func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation)
    func moveSection(_ section: Int, toSection newSection: Int)
    
    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
    func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)
}
