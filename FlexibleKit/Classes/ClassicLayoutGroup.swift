//
//  ClassicLayoutGroup.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutGroup: ClassicLayoutItem {
    
    enum Direction: Hashable {
        
        case horizontal
        
        case vertical
        
    }
    
    // MARK: - Properties
    
    internal var direction: Direction
    
    open var subitems: [ClassicLayoutItem] = []
    
    open var decorationItem: ClassicLayoutItem? = nil
    
    // MARK: - Life cycle
    
    internal init(layoutSize: ClassicLayoutSize, direction: Direction, supplementaryItems: [Any] = []) {
        self.direction = direction
        super.init(layoutSize: layoutSize, supplementaryItems: supplementaryItems)
    }
    
    override func map(for bounds: CGRect, caret: inout CGPoint, indexPath: inout IndexPath) -> [UICollectionViewLayoutAttributes] {
        var size = CGSize(
            width: layoutSize.widthDimension.value(for: bounds.size),
            height: layoutSize.heightDimension.value(for: bounds.size)
        )
        caret.x += contentInsets.left
        caret.y += contentInsets.top
        size.width -= contentInsets.left + contentInsets.right
        size.height -= contentInsets.top + contentInsets.bottom
        let frame = CGRect(origin: caret, size: size)
        
        var layoutMap = [UICollectionViewLayoutAttributes]()
        
        if let item = decorationItem {
            let storedCaret = caret
            let attrs = item.map(for: frame, caret: &caret, indexPath: &indexPath)
            layoutMap.append(contentsOf: attrs)
            
            caret = storedCaret
        }
        
        subitems.enumerated().forEach({ index, item in
            switch direction {
            case .vertical: caret.x = frame.origin.x
            case .horizontal: caret.y = frame.origin.y
            }

            let attrs = item.map(for: frame, caret: &caret, indexPath: &indexPath)
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
        let group = ClassicLayoutGroup(layoutSize: layoutSize, direction: .vertical, supplementaryItems: []) // TODO
        group.subitems = subitems
        
        return group
    }
    
    open class func horizontal(layoutSize: ClassicLayoutSize, subitems: [ClassicLayoutItem]) -> ClassicLayoutGroup {
        let group = ClassicLayoutGroup(layoutSize: layoutSize, direction: .horizontal, supplementaryItems: []) // TODO
        group.subitems = subitems
        
        return group
    }

}
