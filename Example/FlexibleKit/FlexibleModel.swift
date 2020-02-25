//
//  FlexibleModel.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import FlexibleKit

class FlexibleModel: NSObject, FlexibleSupplementaryProvider {
    
    // MARK: - Static
    
    static let headerFont = UIFont.boldSystemFont(ofSize: 24)
    
    static let footerFont = UIFont.systemFont(ofSize: 17)
    
    static var viewsInfo: Dictionary<String, (String, UICollectionReusableView.Type)> {
        return [
            "header": (UICollectionView.elementKindSectionHeader, FlexibleReusableView.self),
            "footer": (UICollectionView.elementKindSectionFooter, FlexibleReusableView.self)
        ]
    }
    
    static func viewId(for kind: String) -> String {
        switch kind {
        case UICollectionView.elementKindSectionHeader: return "header"
        case UICollectionView.elementKindSectionFooter: return "footer"
        default: return String()
        }
    }
    
    // MARK: - Properties
    
    var header = FlexibleSupplementaryItem("Header text", font: headerFont)
    
    var footer = FlexibleSupplementaryItem("footer", font: footerFont)
    
    var items: [Item] = []
    
    public var flatItems: [Item] {
        var result = [Item]()
        items.forEach({
            result.append(contentsOf: $0.flatItems)
        })
        return result
    }
        
    public func load() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        var json: Any? = nil
        do {
            let data = try Data(contentsOf: url)
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {}
        
        update(json)
    }
    
    private func update(_ value: Any?) {
        guard let json = value as? Array<Any> else {
            items = []
            return
        }
        items = json.map({ Item.insert($0, parent: nil) })
    }
    
    // MARK: - Flexible supplementary provider
    
    var headerItem: ClassicLayoutSupplementaryItem {
        let size = ClassicLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(header.height))
        let item = ClassicLayoutSupplementaryItem(UICollectionView.elementKindSectionHeader, layoutSize: size)
        item.contentInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        return item
    }
    
    var footerItem: ClassicLayoutSupplementaryItem {
        let size = ClassicLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(footer.height))
        let item = ClassicLayoutSupplementaryItem(UICollectionView.elementKindSectionFooter, layoutSize: size)
        item.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        
        return item
    }

}

class FlexibleSupplementaryItem: NSObject {
    
    var text: String?
    
    var font: UIFont
    
    init(_ text: String?, font: UIFont) {
        self.text = text
        self.font = font
        super.init()
    }
    
    var height: CGFloat {
        guard let text = text, !text.isEmpty else { return 0 }
        let preset = CGSize(width: UIScreen.main.bounds.width - 40, height: 0)
        return ceil((text as NSString).boundingRect(with: preset, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height) + 20
    }
    
}
