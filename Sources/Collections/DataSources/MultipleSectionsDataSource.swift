import Foundation

open class MultipleSectionsDataSource: BaseViewPresenter, CollectionDataSource {
    public var collectionView: CollectionHolderProtocol? {
        view as? CollectionHolderProtocol
    }
    
    private(set) var sections: [Section]
    
    public init(sections: [Section]) {
        self.sections = sections
    }
    
    public func updateItems(_ items: [Reusable], inSection section: Int) {
        guard section.isValidIndexFor(itemsCount: sections.count) else { return }
        self.sections[section].updateItems(items)
    }
    
    public func updateSections(_ sections: [Section]) {
        self.sections = sections;
    }
    
    // MARK: CollectionDataSource
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        guard isValidSection(section) else { return 0 }
        return sections[section].numberOfItems()
    }
    
    public func headerItemInSection(_ section: Int) -> Reusable? {
        guard isValidSection(section) else { return nil }
        return sections[section].headerItem
    }
    
    public func footerItemInSection(_ section: Int) -> Reusable? {
        guard isValidSection(section) else { return nil }
        return sections[section].footerItem
    }
    
    open func itemAtIndexPath(_ indexPath: IndexPath) -> Reusable? {
        guard isValidIndexPath(indexPath) else { return nil }
        return sections[indexPath.section].itemAtIndex(indexPath.row)
    }
}
