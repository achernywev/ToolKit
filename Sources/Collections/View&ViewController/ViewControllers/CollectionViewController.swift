import UIKit

open class CollectionViewController: CollectionHolderViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet public var collectionView: UICollectionView!
    public override var collection: CollectionProtocol? {
        return collectionView
    }
    
    public var useItemSpacingForLines = true
    public var shouldUseLayoutPropertiesDirectly = false

    public init(presenter: BaseViewPresenterProtocol, layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.collectionView = UICollectionView(frame: .identity, collectionViewLayout: layout)
        super.init(presenter: presenter)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundView = UIView()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if collectionView.superview == nil {
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints {
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.layoutIfNeeded()
        reloadLayout()
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.layoutIfNeeded()
        reloadLayout()
    }
    
    final func reloadLayout() {
        let size = collectionView.bounds.size
        recalculateLayout(for: size)
    }
    
//    final func updateDataSource(_ dataSource: any CollectionDataSource) {
//        self.collectionDataSource = dataSource
//        self.collectionDataSource.view = self
//        
//        collectionView.reloadData()
//    }
    
    func recalculateLayout(for size: CGSize) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionDataSource.numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataSource.numberOfRowsInSection(section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForIndexPath(indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let resultView: UICollectionReusableView? = {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return headerForIndexPath(indexPath)
            case UICollectionView.elementKindSectionFooter:
                return footerForIndexPath(indexPath)
            default:
                return nil
            }
        }()
        guard let resultView else {
            preconditionFailure("This should never happen. Unknown Supplementary kind or empty item from dataSource")
        }
        return resultView
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleSelection(atIndexPath: indexPath)
        
        guard clearsSelectionAutomatically else { return }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) { }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) { }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { }
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.sectionInset
        } else {
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.itemSize
        } else {
            return .zero
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.minimumInteritemSpacing
        } else {
            return 0.0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if useItemSpacingForLines {
            return self.collectionView(collectionView, layout: collectionViewLayout,
                                       minimumInteritemSpacingForSectionAt: section)
        } else if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.minimumLineSpacing
        } else {
            return 0.0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        widthForSection section: Int) -> CGFloat {
        let contentInset = collectionView.contentInset
        let sectionInset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        
        return collectionView.bounds.size.width - contentInset.left - contentInset.right - sectionInset.left - sectionInset.right
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.headerReferenceSize
        } else {
            let width = self.collectionView(collectionView, layout: collectionViewLayout, widthForSection: section)
            let height = heightForHeader(ofWidth: width, in: section)
            return CGSize(width: width, height: height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if shouldUseLayoutPropertiesDirectly, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return flowLayout.footerReferenceSize
        } else {
            let width = self.collectionView(collectionView, layout: collectionViewLayout, widthForSection: section)
            let height = heightForFooter(ofWidth: width, in: section)
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: - CollectionReordering
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    public func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt currentIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return currentIndexPath
    }
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
}
