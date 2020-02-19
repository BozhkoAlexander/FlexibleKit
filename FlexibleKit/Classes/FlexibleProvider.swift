//
//  FlexibleProvider.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

public protocol FlexibleProvider: Hashable {
    
    var classicItem: ClassicLayoutItem { get }
    
    var isSurface: Bool { get }
    
}
