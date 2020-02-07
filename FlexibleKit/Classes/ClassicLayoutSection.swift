//
//  ClassicLayoutSection.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutSection: NSObject {
    
    open var group: ClassicLayoutGroup
    
    // MARK: - Life cycle
    
    public init(group: ClassicLayoutGroup) {
        self.group = group
        super.init()
    }
    
    func map(for bounds: CGRect, caret: inout CGPoint, index: Int) -> [UICollectionViewLayoutAttributes] {
        let indexPath = IndexPath(item: 0, section: index)
        return group.map(for: bounds, caret: &caret, indexPath: indexPath)
    }

}
