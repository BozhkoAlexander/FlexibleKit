//
//  ClassicLayout.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

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
        guard
            let view = collectionView,
            let dataSource = view.dataSource
        else { return }
        let numberOfItems = dataSource.collectionView(view, numberOfItemsInSection: 0)
        layoutMap = (0..<numberOfItems).map({
            let indexPath = IndexPath(item: $0, section: 0)
            return insertItemAttributes(at: indexPath)
        })
    }
    
    // MARK: - Private methods
    
    private func insertItemAttributes(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        guard let view = collectionView else { return attrs }
        
        var size: CGSize = .zero
        size.width = view.bounds.width - (view.contentInset.left + view.contentInset.right)
        size.height = 100
        
        var origin = caret
        origin.x = view.contentInset.left
        origin.y = caret.y
        
        attrs.frame = CGRect(origin: origin, size: size)
        
        caret.y = attrs.frame.maxY
        currentContentSize.width = size.width
        currentContentSize.height = attrs.frame.maxY
        
        return attrs
    }

}
