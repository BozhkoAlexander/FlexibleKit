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
        guard let classic = classic else { return }
        classic.snapshot.willChange()
    }
    
    func changeContent(_ object: ItemIdentifierType, at indexPath: IndexPath, for type: NSFetchedResultsChangeType) {
        guard let classic = classic else { return }
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
    
    func didChangeContent(_ identifiers: [ItemIdentifierType], animated: Bool) {
        guard let classic = classic else { return }
        classic.snapshot.items = identifiers
        classic.snapshot.update(collectionView)
        layout.update(collectionView, animated: animated, snapshot: classic.snapshot)
    }
    
    func reloadData(_ identifiers: [ItemIdentifierType]) {
        guard let classic = classic else { return }
        classic.snapshot.reloadData(identifiers)
        classic.snapshot.update(collectionView)
        layout.update(collectionView, animated: false, snapshot: classic.snapshot)
    }
    
}
