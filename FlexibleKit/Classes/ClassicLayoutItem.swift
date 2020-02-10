//
//  ClassicLayoutItem.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutItem: NSObject {
    
    // MARK: - Properties
    
    open var layoutSize: ClassicLayoutSize
    
    open var contentInsets: UIEdgeInsets = .zero
    
    // MARK: - Life cycle
    
    public init(layoutSize: ClassicLayoutSize, supplementaryItems: [Any] = []) { // TODO
        self.layoutSize = layoutSize
        super.init()
    }
    
    func map(for bounds: CGRect, caret: inout CGPoint, indexPath: inout IndexPath) -> [UICollectionViewLayoutAttributes] {
        // lFrame is layout frame
        let lSyze = CGSize(
            width: layoutSize.widthDimension.value(for: bounds.size),
            height: layoutSize.heightDimension.value(for: bounds.size))
        let lFrame = CGRect(origin: caret, size: lSyze)
        // aFrame is attributes frame (real collection view cell's frame)
        let aFrame = lFrame.inset(by: contentInsets)
        // move caret
        caret.x = lFrame.maxX
        caret.y = lFrame.maxY
        
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.frame = aFrame
        
        indexPath.item += 1
        
        return [attrs]
    }

}
