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
    
    @available(iOS 13.0, *)
    internal typealias Modern = UICollectionViewDiffableDataSource<Section, ItemIdentifierType>
    
    internal typealias Classic = ClassicDataSource<Section, ItemIdentifierType>
    
    public typealias FlexibleCellProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> UICollectionViewCell?
    
    // MARK: - Properties
    
    private var _dataSource: AnyObject? = nil
    
    @available(iOS 13.0, *)
    private var modern: Modern! {
        get { return _dataSource as? Modern }
        set { _dataSource = newValue }
    }
    
    private var classic: Classic! {
        get { return _dataSource as? Classic }
        set { _dataSource = newValue }
    }
    
    private weak var collectionView: UICollectionView? = nil
    
    private var layout: FlexibleLayout<ItemIdentifierType>
    
    // MARK: - Life cycle
    
    override public init() {
        self.layout = FlexibleLayout<ItemIdentifierType>()
        super.init()
    }
    
    // MARK: - Public methods
    
    /// Call this when the collection view is initialized.
    open func start(with collectionView: UICollectionView, cellProvider: @escaping FlexibleCellProvider) {
        if #available(iOS 13.0, *) {
            modern = Modern(collectionView: collectionView, cellProvider: cellProvider)
        } else {
            classic = Classic(collectionView: collectionView, cellProvider: cellProvider)
        }
        
        self.collectionView = collectionView
    }
    
    /// Call this method after start(with:cellProvider:) to register reusable cells.
    open func register(cells: Dictionary<String, UICollectionViewCell.Type>) {
        cells.forEach({ cellId, cellClass in
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellId)
        })
    }
    
    /// Call this method whenever the data model is changed.
    open func update(_ items: Array<ItemIdentifierType>, flat flatIems: Array<ItemIdentifierType>, animated: Bool) {
        if #available(iOS 13.0, *) {
            modernUpdate(flatIems)
        } else {
            classicUpdate(flatIems)
        }
        
        layout.update(collectionView, animated: animated, items: items)
    }
    
    /// Call this method to stop data srouce work.
    open func stop() {
        collectionView = nil
    }
    
    // MARK: - Private methods
    
    @available(iOS 13.0, *)
    private func modernUpdate(_ items: Array<ItemIdentifierType>) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemIdentifierType>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        modern.apply(snapshot)
    }
    
    private func classicUpdate(_ items: Array<ItemIdentifierType>) {
        var snapshot = ClassicDiffableSnapshot<Section, ItemIdentifierType>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        classic.apply(snapshot)
    }

}
