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
    
    internal init(_ dimension: CGFloat) {
        self.dimension = dimension
        super.init()
    }
    
    func value(for availableSize: CGSize) -> CGFloat {
        if isAbsolute {
            return dimension
        } else if isFractionalWidth {
            return round(dimension * availableSize.width)
        } else if isFractionalHeight {
            return round(dimension * availableSize.height)
        }
        return dimension
    }
    
    // MARK: - Methods
    
    // dimension is computed as a fraction of the width of the containing group
    open class func fractionalWidth(_ fractionalWidth: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension(fractionalWidth)
        d.isFractionalWidth = true
        
        return d
    }

    
    // dimension is computed as a fraction of the height of the containing group
    open class func fractionalHeight(_ fractionalHeight: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension(fractionalHeight)
        d.isFractionalHeight = true
        
        return d
    }

    
    // dimension with an absolute point value
    open class func absolute(_ absoluteDimension: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension(absoluteDimension)
        d.isAbsolute = true
        
        return d
    }

    
    // dimension is estimated with a point value. Actual size will be determined when the content is rendered.
    open class func estimated(_ estimatedDimension: CGFloat) -> ClassicLayoutDimension {
        let d = ClassicLayoutDimension(estimatedDimension)
        d.isEstimated = true
        
        return d
    }
    
}
