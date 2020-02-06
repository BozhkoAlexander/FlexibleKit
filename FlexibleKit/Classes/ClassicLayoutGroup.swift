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
    
    // MARK: - Methods
    
    // Specifies a group that will repeat items until available vertical space is exhausted.
    //   note: any remaining space after laying out items can be apportioned among flexible interItemSpacing defintions
    open class func vertical(layoutSize: ClassicLayoutSize, subitems: [ClassicLayoutItem]) -> ClassicLayoutGroup {
        let group = ClassicLayoutGroup(layoutSize: layoutSize, supplementaryItems: []) // TODO
        group.subitems = subitems
        
        return group
    }

}
