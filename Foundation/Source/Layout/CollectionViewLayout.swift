//
//  Created by Jesse on 2019/3/9.
//  Copyright © 2019 Jesse. All rights reserved.
//

// StretchyFlowLayout
// in order to stretch header of collection view when user is scolling.
class StretchyFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let offset = collectionView!.contentOffset
        
        if offset.y < 0 {
            let deltaY = abs(offset.y)
            for attribute in attributes {
                if let elementKind = attribute.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attribute.frame
                        frame.size.height = max(0, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        attribute.frame = frame
                    }
                }
            }
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let _ = collectionView else { return false }
        return true
    }
}

// MARK: Sticky flow layout
class StickyFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        if #available(iOS 9.0, *) {
            self.sectionFootersPinToVisibleBounds = true
            self.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if #available(iOS 9.0, *) {
            self.sectionFootersPinToVisibleBounds = true
            self.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attribute in attributes {
            adjustAttributesIfNeeded(attribute)
        }
        
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        adjustAttributesIfNeeded(attributes)
        return attributes
    }
    
    func adjustAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        switch attributes.representedElementKind {
        case UICollectionView.elementKindSectionHeader?:
            adjustHeaderAttributesIfNeeded(attributes)
        case UICollectionView.elementKindSectionFooter?:
            adjustFooterAttributesIfNeeded(attributes)
        default:
            break
        }
    }
    
    private func adjustHeaderAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        guard attributes.indexPath.section == 0 else { return }
        
        if collectionView.contentOffset.y < 0 {
            attributes.frame.origin.y = collectionView.contentOffset.y
            // comment code above and uncomment code below than it will be sticky + stretchy.
//            let deltaY = abs(collectionView.contentOffset.y)
//            var frame = attributes.frame
//            frame.size.height = max(0, attributes.frame.height + deltaY)
//            frame.origin.y = frame.minY - deltaY
//            attributes.frame = frame
        }
    }
    
    private func adjustFooterAttributesIfNeeded(_ attributes: UICollectionViewLayoutAttributes) {
        guard let collectionView = collectionView else { return }
        guard attributes.indexPath.section == collectionView.numberOfSections - 1 else { return }
        
        if collectionView.contentOffset.y + collectionView.bounds.size.height > collectionView.contentSize.height {
            attributes.frame.origin.y = collectionView.contentOffset.y + collectionView.bounds.size.height - attributes.frame.size.height
        }
    }
}

public extension UICollectionViewCell {
    /// usually called by `preferredLayoutAttributesFitting` func to return fit size
    func layoutSizeFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
