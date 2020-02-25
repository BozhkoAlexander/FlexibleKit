//
//  ClassicLayoutSection.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutSection: NSObject {
    
    open var group: ClassicLayoutGroup
    
    open var supplementaryItems: [ClassicLayoutSupplementaryItem]
    
    private var headerItem: ClassicLayoutSupplementaryItem? {
        return supplementaryItems.filter({ $0.elementKind == UICollectionView.elementKindSectionHeader }).first
    }
    
    private var footerItem: ClassicLayoutSupplementaryItem? {
        return supplementaryItems.filter({ $0.elementKind == UICollectionView.elementKindSectionFooter }).first
    }
    
    // MARK: - Life cycle
    
    public init(group: ClassicLayoutGroup, supplementaryItems: [ClassicLayoutSupplementaryItem] = []) {
        self.group = group
        self.supplementaryItems = supplementaryItems
        super.init()
    }
    
    func map(for bounds: CGRect, caret: inout CGPoint, index: Int) -> [UICollectionViewLayoutAttributes] {
        var sectionPath = IndexPath(item: 0, section: index)
        var indexPath = IndexPath(item: 0, section: index)
        var map = [UICollectionViewLayoutAttributes]()
        
        if let item = headerItem {
            let attrs = item.map(for: bounds, caret: &caret, indexPath: &sectionPath)
            map.append(contentsOf: attrs)
        }
        caret.x = bounds.minX
        let cellAtrs = group.map(for: bounds, caret: &caret, indexPath: &indexPath)
        map.append(contentsOf: cellAtrs)
        if let item = footerItem {
            let attrs = item.map(for: bounds, caret: &caret, indexPath: &sectionPath)
            map.append(contentsOf: attrs)
        }
        
        return map
    }

}
