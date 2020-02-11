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
    
    override init(_ value: Any?) {
        let json = value as? Dictionary<String, Any>
        self.direction = Direction(json?["Direction"])
        super.init(value)
        
        updateSubitems(json?["Items"])
    }
    
    private func updateSubitems(_ value: Any?) {
        if let arrayJson = value as? Array<Any> {
            subitems = arrayJson.map({ Item.insert($0) })
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
    
    @available(iOS 13.0, *)
    override var modernItem: NSCollectionLayoutItem {
        var items = Array<NSCollectionLayoutItem>()
        
        let containerSize = NSCollectionLayoutSize(widthDimension: .absolute(0.1), heightDimension: .absolute(0.1))
        // FIXME: Hardcode. I don't know why, but the callback below is called multiple times without
        // visible reasons. So, I noticed that it's required to call only 3 times to correct displaying cells.
        // I use `flag` variable to control extra calls.
        var flag = 0
        let flagTarget = 3
        let containerItem = NSCollectionLayoutGroup.custom(layoutSize: containerSize) { [weak self] (env) -> [NSCollectionLayoutGroupCustomItem] in
            guard let this = self else { return [] }
            guard flag < flagTarget else { return [] }
            flag += 1
            let margin = this.style.margin
            let width = round(UIScreen.main.bounds.width * this.style.width) - margin.left - margin.right
            let size: CGSize
            if this.direction == .vertical {
                size = CGSize(width: width, height: CGFloat(this.subitems.count) * 60)
            } else {
                size = CGSize(width: width, height: 60)
            }
            let frame = CGRect(origin: .zero, size: size)
            let item = NSCollectionLayoutGroupCustomItem(frame: frame, zIndex: 0)
            
            return [item]
        }
        items.append(containerItem)
        items.append(contentsOf: subitems.map({ $0.modernItem }))
        
        let groupSize: NSCollectionLayoutSize
        let group: NSCollectionLayoutGroup
        switch direction {
        case .vertical:
            let height = (CGFloat(subitems.count) * 60) + style.margin.top + style.margin.bottom
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        case .horizontal:
            let height = 60 + style.margin.top + style.margin.bottom
            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(style.width), heightDimension: .absolute(height))
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        }
        group.contentInsets = style.directionalMargin
        
        return group
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
