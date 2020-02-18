//
//  ClassicDataSource.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class ClassicDataSource<SectionIdentifierType, ItemIdentifierType>: NSObject, UICollectionViewDataSource where SectionIdentifierType: Hashable, ItemIdentifierType: FlexibleProvider {
    
    // MARK: - Properties
    
    private weak var collectionView: UICollectionView? = nil
    
    public var cellProvider: FlexibleDataSource<ItemIdentifierType>.FlexibleCellProvider
    
    public var snapshot = ClassicDiffableSnapshot<SectionIdentifierType, ItemIdentifierType>()
    
    // MARK: - Life cycle
    
    public init(collectionView: UICollectionView, cellProvider: @escaping FlexibleDataSource<ItemIdentifierType>.FlexibleCellProvider) {
        self.collectionView = collectionView
        self.cellProvider = cellProvider
        super.init()
        
        collectionView.dataSource = self
    }
    
    open func apply(_ snapshot: ClassicDiffableSnapshot<SectionIdentifierType, ItemIdentifierType>) {
        self.snapshot = snapshot
        
        snapshot.update(collectionView)
    }
    
    // MARK: - Collection view data source
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return snapshot.numberOfSections
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snapshot.numberOfItems(in: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = snapshot.item(at: indexPath) else { return UICollectionViewCell() }
        let _cell = cellProvider(collectionView, indexPath, item)
        guard let cell = _cell else { return UICollectionViewCell() }
        return cell
    }

}
