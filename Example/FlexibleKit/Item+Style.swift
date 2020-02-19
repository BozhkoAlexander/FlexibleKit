//
//  Item+Style.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension Item {
    
    class Style: NSObject {
        
        var margin: UIEdgeInsets = .zero
        
        var width: CGFloat = 1
        
        init(_ value: Any?) {
            let json = value as? Dictionary<String, Any>
            super.init()
            
            updateWidth(json?["Width"])
            updateMargin(json?["Margin"])
        }
        
        private func updateMargin(_ value: Any?) {
            let json = value as? Dictionary<String, Any>
            margin.left = json?["Left"] as? CGFloat ?? 0
            margin.right = json?["Right"] as? CGFloat ?? 0
            margin.top = json?["Top"] as? CGFloat ?? 0
            margin.bottom = json?["Bottom"] as? CGFloat ?? 0
        }
        
        private func updateWidth(_ value: Any?) {
            let floatValue = value as? CGFloat ?? 12
            width = floatValue / 12
        }
        
    }
    
}
