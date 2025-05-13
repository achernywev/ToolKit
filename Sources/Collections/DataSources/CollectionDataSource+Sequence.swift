import Foundation

public extension Sequence where Self: CollectionDataSource, Element == IndexPath {
    func makeIterator() -> CollectionDataSourceIterator {
        CollectionDataSourceIterator(dataSource: self)
    }
}

public class CollectionDataSourceIterator: IteratorProtocol {
    private weak var dataSource: (any CollectionDataSource)?
    private var nextIndexPathToReturn: IndexPath?

    init(dataSource: (any CollectionDataSource)?) {
        self.dataSource = dataSource
        self.nextIndexPathToReturn = self.nextIndexPath(startingSection: 0, row: 0)
    }

    public func next() -> IndexPath? {
        let valueToReturn = nextIndexPathToReturn
        if let nextIndexPathToReturn {
            self.nextIndexPathToReturn = nextIndexPath(startingSection: nextIndexPathToReturn.section,
                                                       row: nextIndexPathToReturn.row + 1)
        } else {
            self.nextIndexPathToReturn = nil
        }
        return valueToReturn
    }
    
    private func nextIndexPath(startingSection section: Int, row: Int) -> IndexPath? {
        guard let dataSource else { return nil }
        
        var row = row
        var section = section
        let totalNumOfSections = dataSource.numberOfSections()
        while section < totalNumOfSections {
            if dataSource.numberOfRowsInSection(section) > row {
                return IndexPath(row: row, section: section)
            } else {
                row = 0
                section += 1
            }
        }
        return nil
    }
}
