//
//  ClassicLayout.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

typealias LayoutResult = (frame: CGRect, attrs: [UICollectionViewLayoutAttributes])

class ClassicLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    
    private var currentContentSize: CGSize = .zero
    
    private var layoutMap: [UICollectionViewLayoutAttributes] = []
    
    private var caret: CGPoint = .zero
    
    private var section: ClassicLayoutSection
    
    // MARK: - Life cycle
    
    init(section: ClassicLayoutSection) {
        self.section = section
        super.init()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Overrides
    
    override var collectionViewContentSize: CGSize {
        return currentContentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutMap.filter({ rect.intersects($0.frame) })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutMap.filter({ $0.indexPath == indexPath }).first
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let view = collectionView, !view.bounds.size.equalTo(newBounds.size) else { return false }
        currentContentSize = .zero
        layoutMap = []
        caret = .zero
        return true
    }
    
    override func prepare() {
        super.prepare()
        
        createLayoutMap()
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let view = collectionView else { return proposedContentOffset }
        return view.contentOffset
    }

    
    // MARK: - Private methods
    
    private func createLayoutMap() {
        guard let view = collectionView else { return }
        var availableFrame = view.bounds
        if #available(iOS 11.0, *) {
            availableFrame = availableFrame.inset(by: view.safeAreaInsets)
        } else {
            availableFrame.size.height -= availableFrame.origin.y
            availableFrame.origin.y = 0
        }
        availableFrame = availableFrame.inset(by: view.contentInset)
        
        caret = availableFrame.origin
        layoutMap = section.map(for: availableFrame, caret: &caret, index: 0)
        currentContentSize = CGSize(width: caret.x, height: caret.y)
    }

}
