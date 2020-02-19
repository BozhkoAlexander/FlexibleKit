//
//  Item.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FlexibleKit

class Item: NSObject, FlexibleProvider {
    
    // MARK: - Properties
        
    var type: ItemType
    
    var style: Style
    
    var title: String?
    
    weak var parent: Item? = nil
    
    // MARK: - Life cycle
    
    class func insert(_ value: Any?, parent: Item?) -> Item {
        let json = value as? Dictionary<String, Any>
        let type = ItemType(json?["Type"])
        
        switch type {
        case .flexible: return Item(value, parent: parent)
        case .container: return Container(value, parent: parent)
        }
    }
    
    init(_ value: Any?, parent: Item?) {
        let json = value as? Dictionary<String, Any>
        self.type = ItemType(json?["Type"])
        self.style = Style(json?["Style"])
        self.title = json?["Title"] as? String
        self.parent = parent
        super.init()
     }
    
    // MARK: - Flexible provider
    
    var flatItems: [Item] { return [self] }
    
    var isSurface: Bool { return parent == nil }
    
    var classicItem: ClassicLayoutItem {
        let height = 60 + style.margin.top + style.margin.bottom
        let size = ClassicLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
        let item = ClassicLayoutItem(layoutSize: size)
        item.contentInsets = style.margin
        return item
    }

}
