//
//  FlexibleDataSource+CoreData.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 19.02.2020.
//

import Foundation
import CoreData

public extension FlexibleDataSource {
    
    /// Prepares data source for data model changes.
    func willChangeContent() {
        classic.snapshot.willChange()
    }
    
    func changeContent(_ object: ItemIdentifierType, at indexPath: IndexPath, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            classic.snapshot.insertItem(object, at: indexPath)
        case .update:
            classic.snapshot.reloadItem(object, at: indexPath)
        case .delete:
            classic.snapshot.deleteItem(object, at: indexPath)
        default: break
        }
    }
    
    func didChangeContent(_ animated: Bool) {
        classic.snapshot.update(collectionView)
        layout.update(collectionView, animated: animated, snapshot: classic.snapshot)
    }
    
    func update(_ identifiers: [ItemIdentifierType]) {
        classic.snapshot.items = identifiers
        layout.update(collectionView, animated: false, snapshot: classic.snapshot)
    }
    
}
