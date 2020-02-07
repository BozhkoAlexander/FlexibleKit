//
//  ClassicLayoutGroup.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutGroup: ClassicLayoutItem {
    
    // MARK: - Properties
    
    open var subitems: [ClassicLayoutItem] = []
    
    // MARK: - Life cycle
    
    override func map(for bounds: CGRect, caret: inout CGPoint, indexPath: IndexPath) -> [UICollectionViewLayoutAttributes] {
        let size = CGSize(
            width: layoutSize.widthDimension.value(for: bounds.size),
            height: layoutSize.heightDimension.value(for: bounds.size))
        caret.x += contentInsets.left
        caret.y += contentInsets.top
        let frame = CGRect(origin: caret, size: size)
        
        var layoutMap = [UICollectionViewLayoutAttributes]()
        subitems.enumerated().forEach({ index, item in
            caret.x = frame.origin.x

            let path = IndexPath(item: indexPath.item + index, section: indexPath.section)
            let attrs = item.map(for: frame, caret: &caret, indexPath: path)
            
            layoutMap.append(contentsOf: attrs)
        })
        
        caret.x += contentInsets.right
        caret.y += contentInsets.bottom
        
        return layoutMap
    }
    
    // MARK: - Methods
    
    // Specifies a group that will repeat items until available vertical space is exhausted.
    //   note: any remaining space after laying out items can be apportioned among flexible interItemSpacing defintions
    open class func vertical(layoutSize: ClassicLayoutSize, subitems: [ClassicLayoutItem]) -> ClassicLayoutGroup {
        let group = ClassicLayoutGroup(layoutSize: layoutSize, supplementaryItems: []) // TODO
        group.subitems = subitems
        
        return group
    }

}
