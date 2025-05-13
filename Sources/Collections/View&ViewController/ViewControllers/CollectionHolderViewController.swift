import UIKit

public protocol EmptyStateDependencyProtocol: AnyObject {
    
    func setupEmptyState(for collectionView: CollectionProtocol?)
}

open class CollectionHolderViewController: ViewController, CollectionHolderProtocol {
    public weak var emptyStateDependency: EmptyStateDependencyProtocol?
    
    public var viewPrototypes: [String : UIView] = [:]
    public var collectionDataSource: any CollectionDataSource {
        return presenter as! (any CollectionDataSource)
    }
    public var collection: CollectionProtocol? {
        preconditionFailure("This property should be overriden in subclasses")
    }
    
    //MARK: properties to override
    open var clearsSelectionAutomatically: Bool { true }
    open var emptyStateContent: EmptyStateContent? { nil }
    
    public var hasRefreshControl: Bool = false {
        didSet {
            if oldValue != hasRefreshControl {
                if hasRefreshControl == true {
                    let refreshControl = UIRefreshControl()
                    refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
                    self.refreshControl = refreshControl
                }
                else {
                    refreshControl = nil
                }
            }
        }
    }
    
    //MARK: overrided methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyStateDependency = self as? EmptyStateDependencyProtocol
        
        let backView = UIView()
        backView.backgroundColor = dependency?.backgroundColor
        collection?.backgroundView = backView
        
        emptyStateDependency?.setupEmptyState(for: collection)
        collection?.reloadData()
    }
    
    public override func endLoading() {
        super.endLoading()
        refreshControl?.endRefreshing()
    }
    
    //MARK: Actions
    @IBAction open func refreshControlAction() {
        
    }
    
    @IBAction open func emptyStateButtonAction() {
        
    }
}
