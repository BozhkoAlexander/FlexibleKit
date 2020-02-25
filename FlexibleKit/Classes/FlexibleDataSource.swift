//
//  FlexibleDataSource.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class FlexibleDataSource<SectionIdentifierType, ItemIdentifierType>: NSObject where SectionIdentifierType: FlexibleSupplementaryProvider, ItemIdentifierType: FlexibleProvider {
    
    // MARK: - Helpers
    
    internal typealias Classic = ClassicDataSource<SectionIdentifierType, ItemIdentifierType>
    
    public typealias FlexibleCellProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> UICollectionViewCell?
    
    public typealias FlexibleViewProvider = (UICollectionView, String, IndexPath, SectionIdentifierType) -> UICollectionReusableView?
    
    // MARK: - Properties
    
    private var _dataSource: AnyObject? = nil
    
    internal var classic: Classic! {
        get { return _dataSource as? Classic }
        set { _dataSource = newValue }
    }
    
    internal weak var collectionView: UICollectionView? = nil
    
    internal var layout: FlexibleLayout<SectionIdentifierType, ItemIdentifierType>
    
    // MARK: - Life cycle
    
    override public init() {
        self.layout = FlexibleLayout<SectionIdentifierType, ItemIdentifierType>()
        super.init()
    }
    
    // MARK: - Public methods
    
    /// Call this when the collection view is initialized.
    open func start(with collectionView: UICollectionView, cellProvider: @escaping FlexibleCellProvider) {
        classic = Classic(collectionView: collectionView, cellProvider: cellProvider)
        
        self.collectionView = collectionView
    }
    
    /// Call this method after start(with:cellProvider:) to register reusable cells.
    open func register(cells: Dictionary<String, UICollectionViewCell.Type>) {
        cells.forEach({ cellId, cellClass in
            collectionView?.register(cellClass, forCellWithReuseIdentifier: cellId)
        })
    }
    
    /// Call this method after start(with:cellProvider:) to register reusable views.
    open func register(views: Dictionary<String, (String, UICollectionReusableView.Type)>) {
        views.forEach({ viewId, v in
            collectionView?.register(v.1, forSupplementaryViewOfKind: v.0, withReuseIdentifier: viewId)
        })
    }
    
    /// Call this to define section.
    open func appendSection(_ section: SectionIdentifierType, viewProvider: FlexibleViewProvider?) {
        classic.viewProvider = viewProvider
        classic.snapshot.appendSections([section])
    }
    
    /// Call this method to stop data srouce work.
    open func stop() {
        collectionView = nil
    }

}
