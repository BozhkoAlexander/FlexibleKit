//
//  Container.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 07.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FlexibleKit

class Container: Item {
    
    // MARK: - Direction
    
    enum Direction: String {
        
        case horizontal = "horizontal"
        
        case vertical = "vertical"
        
        init(_ value: Any?) {
            if let raw = value as? String, let direction = Direction(rawValue: raw) {
                self = direction
            } else {
                self = .vertical
            }
        }
        
    }
    
    // MARK: - Properties
    
    var direction: Direction
    
    var subitems: Array<Item> = []
    
    // MARK: - Life cycle
    
    override init(_ value: Any?, parent: Item?) {
        let json = value as? Dictionary<String, Any>
        self.direction = Direction(json?["Direction"])
        super.init(value, parent: parent)
        
        updateSubitems(json?["Items"])
    }
    
    private func updateSubitems(_ value: Any?) {
        if let arrayJson = value as? Array<Any> {
            subitems = arrayJson.map({ Item.insert($0, parent: self) })
        } else {
            subitems = []
        }
    }
    
    // MARK: - Flexible provider
    
    override var flatItems: [Item] {
        var result = super.flatItems
        subitems.forEach({
            result.append(contentsOf: $0.flatItems)
        })
        
        return result
    }
    
    override var classicItem: ClassicLayoutItem {
        let items = subitems.map({ $0.classicItem })
        let height = 60 + style.margin.top + style.margin.bottom
        let groupSize = ClassicLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
        let group: ClassicLayoutGroup
        switch direction {
        case .vertical:
            group = ClassicLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        case .horizontal:
            group = ClassicLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        }
        let decorationSize = ClassicLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        group.decorationItem = ClassicLayoutItem(layoutSize: decorationSize)
        group.contentInsets = style.margin
        
        return group
    }

}
