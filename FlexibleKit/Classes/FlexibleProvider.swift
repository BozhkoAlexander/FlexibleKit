//
//  FlexibleProvider.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

public protocol FlexibleProvider: Hashable {
    
    @available(iOS 13.0, *)
    var modernItem: NSCollectionLayoutItem { get }
    
    var classicItem: ClassicLayoutItem { get }
    
}
