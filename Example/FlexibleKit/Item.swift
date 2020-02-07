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
    
    init(_ value: Any?) {
        let json = value as? Dictionary<String, Any>
        self.type = ItemType(json?["Type"])
        self.style = Style(json?["Style"])
        self.title = json?["Title"] as? String
        super.init()
     }
    
    // MARK: - Flexible provider
    
    @available(iOS 13.0, *)
    var modernItem: NSCollectionLayoutItem {
        let height = 60 + style.margin.top + style.margin.bottom
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = style.directionalMargin
        return item
    }
    
    var classicItem: ClassicLayoutItem {
        let height = 60 + style.margin.top + style.margin.bottom
        let size = ClassicLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height))
        let item = ClassicLayoutItem(layoutSize: size)
        item.contentInsets = style.margin
        return item
    }

}
