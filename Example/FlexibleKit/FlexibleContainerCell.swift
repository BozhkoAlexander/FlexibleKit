//
//  FlexibleContainerCell.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 07.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FlexibleContainerCell: FlexibleCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
