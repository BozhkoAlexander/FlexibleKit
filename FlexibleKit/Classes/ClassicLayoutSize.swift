//
//  ClassicLayoutSize.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutSize: NSObject {
    
    open var widthDimension: ClassicLayoutDimension

    open var heightDimension: ClassicLayoutDimension
    
    public init(widthDimension width: ClassicLayoutDimension, heightDimension height: ClassicLayoutDimension) {
        self.widthDimension = width
        self.heightDimension = height
        
        super.init()
    }

}

open class ClassicLayoutDimension: NSObject {
    
    // MARK: - Properties
    
    open var isFractionalWidth: Bool = false

    open var isFractionalHeight: Bool = false

    open var isAbsolute: Bool = false

    open var isEstimated: Bool = false

    open var dimension: CGFloat
    
    // MARK: - Life cycle
    
    internal override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    // dimension is computed as a fraction of the width of the containing group
    open class func fractionalWidth(_ fractionalWidth: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension()
        d.isFractionalWidth = true
        d.dimension = fractionalWidth
        
        return d
    }

    
    // dimension is computed as a fraction of the height of the containing group
    open class func fractionalHeight(_ fractionalHeight: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension()
        d.isFractionalHeight = true
        d.dimension = fractionalHeight
        
        return d
    }

    
    // dimension with an absolute point value
    open class func absolute(_ absoluteDimension: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension()
        d.isAbsolute = true
        d.dimension = absoluteDimension
        
        return d
    }

    
    // dimension is estimated with a point value. Actual size will be determined when the content is rendered.
    open class func estimated(_ estimatedDimension: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension()
        d.isEstimated = true
        d.dimension = estimatedDimension
        
        return d
    }
    
}
