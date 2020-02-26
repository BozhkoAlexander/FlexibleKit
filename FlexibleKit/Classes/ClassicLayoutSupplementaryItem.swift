//
//  ClassicLayoutSupplementaryItem.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 25.02.2020.
//

import UIKit

open class ClassicLayoutSupplementaryItem: ClassicLayoutItem {
    
    open var elementKind: String
    
    public init(_ kind: String, layoutSize: ClassicLayoutSize) {
        self.elementKind = kind
        super.init(layoutSize: layoutSize)
    }
    
    // MARK: - Map
    
    override func map(for bounds: CGRect, caret: inout CGPoint, indexPath: inout IndexPath) -> [UICollectionViewLayoutAttributes] {
        caret.x = bounds.minX

        // lFrame is layout frame
        let lSyze = CGSize(
            width: layoutSize.widthDimension.value(for: bounds.size),
            height: layoutSize.heightDimension.value(for: bounds.size))
        let lFrame = CGRect(origin: caret, size: lSyze)
         
        let attrs = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        attrs.frame = lFrame.inset(by: contentInsets)
        attrs.zIndex = -1
        
        caret.x = lFrame.maxX
        caret.y = lFrame.maxY
        return [attrs]
    }

}
