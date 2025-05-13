import Foundation

open class Section {
    private(set) var headerItem: Reusable?
    private(set) var footerItem: Reusable?
    private var items: [Reusable] = []
    
    public init(items: [Reusable], headerItem: Reusable? = nil, footerItem: Reusable? = nil) {
        self.updateItems(items, headerItem: headerItem, footerItem: footerItem)
    }
    
    
    public func updateItems(_ items: [Reusable], headerItem: Reusable? = nil, footerItem: Reusable? = nil) {
        self.items = items
        self.headerItem = headerItem
        self.footerItem = footerItem
    }
    
    open func updateItem(at index: Int, using updater: ((inout Reusable) -> Void))  {
        updater(&items[index])
    }
    
    public func numberOfItems() -> Int {
        items.count
    }
    
    public func itemAtIndex(_ index: Int) -> Reusable {
        items[index]
    }
    
    public func indexOfItem(where: (Reusable) -> Bool) -> Int? {
        items.firstIndex(where: `where`)
    }
    
    public static func empty() -> Section {
        Section(items: [])
    }
}
