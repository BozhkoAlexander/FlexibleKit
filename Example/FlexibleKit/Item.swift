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
    
    // MARK: - Life cycle
    
    class func insert(_ value: Any?) -> Item {
        let json = value as? Dictionary<String, Any>
        let type = ItemType(json?["Type"])
        
        switch type {
        case .flexible: return Item(value)
        case .container: return Container(value)
        }
    }
    
    init(_ value: Any?) {
        let json = value as? Dictionary<String, Any>
        self.type = ItemType(json?["Type"])
        self.style = Style(json?["Style"])
        self.title = json?["Title"] as? String
        super.init()
     }
    
    // MARK: - Flexible provider
    
    var flatItems: [Item] { return [self] } 
    
    @available(iOS 13.0, *)
    var modernItem: NSCollectionLayoutItem {
        let height = 60 + style.margin.top + style.margin.bottom
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = style.directionalMargin
        return item
    }
    
    var classicItem: ClassicLayoutItem {
        let height = 60 + style.margin.top + style.margin.bottom
        let size = ClassicLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
        let item = ClassicLayoutItem(layoutSize: size)
        item.contentInsets = style.margin
        return item
    }

}
