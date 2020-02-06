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

open class FlexibleDataSource<SectionIdentifierType, ElementIdentifierType>: NSObject where SectionIdentifierType: Hashable, ElementIdentifierType: Hashable {
    
    // MARK: - Helpers
    
    @available(iOS 13.0, *)
    internal typealias Modern = UICollectionViewDiffableDataSource<SectionIdentifierType, ElementIdentifierType>
    
    internal typealias Classic = ClassicDataSource<SectionIdentifierType, ElementIdentifierType>
    
    // MARK: - Properties
    
    private var _dataSource: AnyObject? = nil
    
    @available(iOS 13.0, *)
    private var flex: Modern! {
        get { return _dataSource as? Modern }
        set { _dataSource = newValue }
    }
    
    private var classic: Classic! {
        get { return _dataSource as? Classic }
        set { _dataSource = newValue }
    }

}
