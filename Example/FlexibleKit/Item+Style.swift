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
        
        @available(iOS 13.0, *)
        var directionalMargin: NSDirectionalEdgeInsets {
            return NSDirectionalEdgeInsets(top: margin.top, leading: margin.left, bottom: margin.bottom, trailing: margin.right)
        }
        
        init(_ value: Any?) {
            let json = value as? Dictionary<String, Any>
            super.init()
            
            updateMargin(json?["Margin"])
        }
        
        private func updateMargin(_ value: Any?) {
            let json = value as? Dictionary<String, Any>
            margin.left = json?["Left"] as? CGFloat ?? 0
            margin.right = json?["Right"] as? CGFloat ?? 0
            margin.top = json?["Top"] as? CGFloat ?? 0
            margin.bottom = json?["Bottom"] as? CGFloat ?? 0
        }
        
    }
    
}
