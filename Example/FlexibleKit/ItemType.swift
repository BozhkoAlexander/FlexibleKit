//
//  ItemType.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

enum ItemType: Int, CaseIterable {
    
    case flexible = 140
    
    init(_ value: Any?) {
        if let raw = value as? Int, let type = ItemType(rawValue: raw) {
            self = type
        } else {
            self = .flexible
        }
    }
    
    var cellId: String {
        switch self {
        case .flexible: return "flexible"
        }
    }
    
    var cellClass: UICollectionViewCell.Type {
        switch self {
        case .flexible: return FlexibleCell.self
        }
    }
    
    static var cellsInfo: Dictionary<String, UICollectionViewCell.Type> {
        var info = Dictionary<String, UICollectionViewCell.Type>()
        
        ItemType.allCases.forEach({ type in
            info[type.cellId] = type.cellClass
        })
        
        return info
    }
    
}
