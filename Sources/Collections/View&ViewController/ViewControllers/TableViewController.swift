import UIKit
import SnapKit

open class TableViewController: CollectionHolderViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet public var tableView: UITableView!
    public override var collection: CollectionProtocol? {
        return tableView
    }

    public init(presenter: BaseViewPresenterProtocol, style: UITableView.Style = .grouped) {
        self.tableView = UITableView(frame: .identity, style: style)
        super.init(presenter: presenter)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.backgroundView = UIView()
        tableView.sectionHeaderTopPadding = 0
        UITableView.appearance().sectionHeaderTopPadding = 0
        UITableView.appearance().sectionFooterHeight = 0
        
        if tableView.superview == nil {
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return collectionDataSource.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionDataSource.numberOfRowsInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForIndexPath(indexPath)
    }
    
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard collectionDataSource.headerItemInSection(section) != nil else { return nil }
        
        let indexPath = IndexPath(row: 0, section: section)
        return headerForIndexPath(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard collectionDataSource.footerItemInSection(section) != nil else { return nil }
        
        let indexPath = IndexPath(row: 0, section: section)
        return footerForIndexPath(indexPath)
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard collectionDataSource.headerItemInSection(section) != nil else { return .leastNormalMagnitude }
        return 1.0
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let width = tableView.bounds.size.width - tableView.contentInset.left - tableView.contentInset.right
        return heightForHeader(ofWidth: width, in: section)
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard collectionDataSource.footerItemInSection(section) != nil else { return .leastNormalMagnitude }
        return 1.0
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let width = tableView.bounds.size.width - tableView.contentInset.left - tableView.contentInset.right
        return heightForFooter(ofWidth: width, in: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelection(atIndexPath: indexPath)
        
        guard clearsSelectionAutomatically else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
