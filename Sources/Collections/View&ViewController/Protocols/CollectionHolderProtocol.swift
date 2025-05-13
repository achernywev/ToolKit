import UIKit

public protocol CollectionHolderProtocol: BaseViewProtocol {
    var collection: CollectionProtocol? { get }
    var viewPrototypes: [String: UIView] { get set }
    var collectionDataSource: any CollectionDataSource { get }
}

private enum CollectionViewType: String {
    case cell, header, footer
}

public extension CollectionHolderProtocol {
    var refreshControl: UIRefreshControl? {
        get { collection?.refreshControl }
        set { collection?.refreshControl = newValue }
    }
    
    func cellForIndexPath<Cell: UIView>(_ indexPath: IndexPath) -> Cell {
        return collectionSubView(atIndexPath: indexPath, type: .cell, itemFetching: self.cellItemFetching,
                                 itemRegistration: self.cellItemRegistration, viewFetching: self.cellViewFetching)
    }
    
    func headerForIndexPath<Header: UIView>(_ indexPath: IndexPath) -> Header {
        return collectionSubView(atIndexPath: indexPath, type: .header, itemFetching: self.headerItemFetching,
                                 itemRegistration: self.headerItemRegistration, viewFetching: self.headerViewFetching)
    }
    
    func footerForIndexPath<Footer: UIView>(_ indexPath: IndexPath) -> Footer {
        return collectionSubView(atIndexPath: indexPath, type: .footer, itemFetching: self.footerItemFetching,
                                 itemRegistration: self.footerItemRegistration, viewFetching: self.footerViewFetching)
    }
    
    func heightForHeader(ofWidth width: CGFloat, in section: Int) -> CGFloat {
        return sizeForView(fitting: CGSize(width: width, height: .infinity), atIndex: section, type: .header,
                           itemFetching: self.headerItemSectionFetching, itemRegistration: self.headerItemRegistration).height
    }
    
    func heightForFooter(ofWidth width: CGFloat, in section: Int) -> CGFloat {
        return sizeForView(fitting: CGSize(width: width, height: .infinity), atIndex: section, type: .footer,
                           itemFetching: self.footerItemSectionFetching, itemRegistration: self.footerItemRegistration).height
    }
    
    func heightForCell(ofWidth width: CGFloat, at indexPath: IndexPath) -> CGFloat {
        return sizeForView(fitting: CGSize(width: width, height: .infinity), atIndex: indexPath, type: .cell,
                           itemFetching: self.cellItemFetching, itemRegistration: self.cellItemRegistration).height
    }
    
    func handleSelection(atIndexPath indexPath: IndexPath) {
        let item = collectionDataSource.itemAtIndexPath(indexPath)
        guard let selectableItem = item as? (any IndexPathSelectable) else { return }
        selectableItem.triggerSelection(for: indexPath)
    }
    
    private func collectionSubView<View: UIView>(atIndexPath indexPath: IndexPath, type: CollectionViewType,
                                                 itemFetching: ItemFetching, itemRegistration: ItemRegistration?,
                                                 viewFetching: ViewFetching?) -> View {
        guard let item = itemFetching(indexPath) else {
            preconditionFailure("Item for indexPath: \(indexPath) is nil")
        }
        prototypeViewByRegisteringIdentifier(for: item, ofType: type, itemRegistration: itemRegistration)
        guard let view = viewFetching?(item, indexPath) as? View else {
            preconditionFailure("View is nil or not a \(View.self) type")
        }
        return view.configuringViewItem(item)
    }
    
    private func sizeForView<Index>(fitting size: CGSize, atIndex index: Index, type: CollectionViewType,
                                    itemFetching: (Index) -> Reusable?,
                                    itemRegistration:ItemRegistration?) -> CGSize {
        guard let item = itemFetching(index) else { return .zero }
        let view = prototypeViewByRegisteringIdentifier(for: item, ofType: type, itemRegistration: itemRegistration)
            .configuringViewItem(item)
        view.safeLayoutIfNeeded()
        let calculatedSize = view.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required,
                                                          verticalFittingPriority: .fittingSizeLevel)
        return calculatedSize
    }
    
    @discardableResult
    private func prototypeViewByRegisteringIdentifier(for item: Reusable, ofType type: CollectionViewType,
                                                      itemRegistration:((Reusable)->Void)?) -> UIView {
        let key = type.rawValue + ": " + item.reuseIdentifier
        if let prototype = viewPrototypes[key] {
            return prototype
        } else {
            let view = item.viewClass.init(frame: .identity)
            viewPrototypes[key] = view
            itemRegistration?(item)
            return view
        }
    }
}

// MARK: - Supporing Code
private extension CollectionDataSource {
    func headerItemAtIndexPath(_ indexPath: IndexPath) -> Reusable? {
        return headerItemInSection(indexPath.section)
    }
    
    func footerItemAtIndexPath(_ indexPath: IndexPath) -> Reusable? {
        return footerItemInSection(indexPath.section)
    }
}

private extension UIView {
    func configuringViewItem(_ item: Any) -> Self {
        if let configurableView = self as? Configurable {
            configurableView.configureForItem(item)
        }
        return self
    }
}

private class PrototypeItem: Reusable {
    var viewClass: UIView.Type {
        baseItem.viewClass
    }
    var reuseIdentifier: String {
        return baseItem.reuseIdentifier + "prototype"
    }
    
    let baseItem: Reusable
    init(item: Reusable) {
        self.baseItem = item
    }
}

// MARK: Items Fetching
private  extension CollectionHolderProtocol {
    typealias ItemFetching = (IndexPath) -> Reusable?
    
    var cellItemFetching: ItemFetching {
        collectionDataSource.itemAtIndexPath(_:)
    }
    
    var headerItemFetching: ItemFetching {
        collectionDataSource.headerItemAtIndexPath(_:)
    }
    var headerItemSectionFetching: (Int) -> Reusable? {
        collectionDataSource.headerItemInSection(_:)
    }
    
    var footerItemFetching: ItemFetching {
        collectionDataSource.footerItemAtIndexPath(_:)
    }
    var footerItemSectionFetching: (Int) -> Reusable? {
        collectionDataSource.footerItemInSection(_:)
    }
}

// MARK: Items Registration
private  extension CollectionHolderProtocol {
    typealias ItemRegistration = (Reusable) -> Void
    
    var cellItemRegistration: ItemRegistration? {
        collection?.registerCell(forItem:)
    }
    
    var headerItemRegistration: ItemRegistration? {
        collection?.registerHeader(forItem:)
    }
    
    var footerItemRegistration: ItemRegistration? {
        collection?.registerFooter(forItem:)
    }
}

// MARK: View Fetching
private  extension CollectionHolderProtocol {
    typealias ViewFetching = (Reusable, IndexPath) -> UIView
    
    var cellViewFetching: ViewFetching? {
        collection?.dequeueReusableCell(forItem:for:)
    }
    
    var headerViewFetching: ViewFetching? {
        collection?.dequeueReusableHeaderView(forItem:for:)
    }
    
    var footerViewFetching: ViewFetching? {
        collection?.dequeueReusableFooterView(forItem:for:)
    }
}
