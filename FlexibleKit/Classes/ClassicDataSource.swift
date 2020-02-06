//
//  ClassicDataSource.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

internal class ClassicDataSource<SectionIdentifierType, ItemIdentifierType>: NSObject where SectionIdentifierType: Hashable, ItemIdentifierType: FlexibleProvider {
    
    // MARK: - Helpers
    
    
    
    // MARK: - Life cycle
    
    init(collectionView: UICollectionView, cellProvider: FlexibleDataSource<ItemIdentifierType>.FlexibleCellProvider?) {
        super.init()
    }

}
