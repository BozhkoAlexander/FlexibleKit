//
//  FlexibleDataSource.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

public enum Section: Hashable {
    
    case main
    
}

open class FlexibleDataSource<ItemIdentifierType>: NSObject where ItemIdentifierType: FlexibleProvider {
    
    // MARK: - Helpers
    
    internal typealias Classic = ClassicDataSource<Section, ItemIdentifierType>
    
    public typealias FlexibleCellProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> UICollectionViewCell?
    
    // MARK: - Properties
    
    private var _dataSource: AnyObject? = nil
    
    internal var classic: Classic! {
        get { return _dataSource as? Classic }
        set { _dataSource = newValue }
    }
    
    internal weak var collectionView: UICollectionView? = nil
    
    internal var layout: FlexibleLayout<ItemIdentifierType>
    
    // MARK: - Life cycle
    
    override public init() {
        self.layout = FlexibleLayout<ItemIdentifierType>()
        super.init()
    }
    
    // MARK: - Public methods
    
    /// Call this when the collection view is initialized.
    open func start(with collectionView: UICollectionView, cellProvider: @escaping FlexibleCellProvider) {
        classic = Classic(collectionView: collectionView, cellProvider: cellProvider)
        classic.snapshot.appendSections([.main])
        
        self.collectionView = collectionView
    }
    
    /// Call this method after start(with:cellProvider:) to register reusable cells.
    open func register(cells: Dictionary<String, UICollectionViewCell.Type>) {
        cells.forEach({ cellId, cellClass in
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellId)
        })
    }
    
    /// Call this method to stop data srouce work.
    open func stop() {
        collectionView = nil
    }

}
