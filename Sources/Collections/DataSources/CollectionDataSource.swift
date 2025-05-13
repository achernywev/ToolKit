import Foundation

public protocol CollectionDataSource: AnyObject, Sequence {
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func headerItemInSection(_ section: Int) -> Reusable?
    func footerItemInSection(_ section: Int) -> Reusable?
    func itemAtIndexPath(_ indexPath: IndexPath) -> Reusable?
}

public extension CollectionDataSource {
    var isNotEmpty: Bool { !isEmpty }
    var isEmpty: Bool {
        let numberOfSection = numberOfSections()
        for section in 0 ..< numberOfSection {
            guard numberOfRowsInSection(section) > 0 else { continue }
            return false
        }
        return true
    }
    
    var totalNumberOfItems: Int {
        let numOfSections = numberOfSections()
        return (0 ..< numOfSections).sumWithMapping { section in
            self.numberOfRowsInSection(section)
        }
    }
    
    func isValidSection(_ section: Int) -> Bool {
        return section.isValidIndexFor(itemsCount: numberOfSections())
    }
    
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        guard indexPath.section.isValidIndexFor(itemsCount: numberOfSections()) else { return false }
        
        let numberOfItemsInSection = numberOfRowsInSection(indexPath.section)
        return indexPath.row.isValidIndexFor(itemsCount: numberOfItemsInSection)
    }
}
