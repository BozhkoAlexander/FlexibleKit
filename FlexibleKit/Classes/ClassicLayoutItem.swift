//
//  ClassicLayoutItem.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicLayoutItem: NSObject {
    
    // MARK: - Properties
    
    open var layoutSize: ClassicLayoutSize
    
    open var contentInsets: UIEdgeInsets = .zero
    
    open var verticalAlignment: Alignment = .top
    
    // MARK: - Life cycle
    
    public init(layoutSize: ClassicLayoutSize, supplementaryItems: [Any] = []) { // TODO
        self.layoutSize = layoutSize
        super.init()
    }
    
    func map(for bounds: CGRect, caret: inout CGPoint, indexPath: inout IndexPath) -> [UICollectionViewLayoutAttributes] {
        // lFrame is layout frame
        let lSyze = CGSize(
            width: layoutSize.widthDimension.value(for: bounds.size),
            height: layoutSize.heightDimension.value(for: bounds.size))
        var lFrame = CGRect(origin: caret, size: lSyze)
        switch verticalAlignment {
        case .center: lFrame.origin.y = caret.y + round(0.5 * (bounds.height - lFrame.height))
        case .bottom: lFrame.origin.y = caret.y + round(bounds.height - lFrame.height)
        case .justify: lFrame.size.height = bounds.height
        default: break
        }
        // aFrame is attributes frame (real collection view cell's frame)
        let aFrame = lFrame.inset(by: contentInsets)
        // move caret
        caret.x = lFrame.maxX
        caret.y = lFrame.maxY
        
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.frame = aFrame
        attrs.zIndex = indexPath.item
        
        indexPath.item += 1
        
        return [attrs]
    }

}

public enum Alignment: String {
    
    case left = "left"
    
    case right = "right"
    
    case top = "top"
        
    case bottom = "bottom"
    
    case center = "center"
    
    case justify = "justify"
    
    public init(_ value: Any?) {
        guard let raw = value as? String, let alignment = Alignment(rawValue: raw) else {
            self = .top
            return
        }
        self = alignment
    }
    
}
