//
//  ClassicDiffableSnapshot.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

public struct ClassicDiffableSnapshot<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    private typealias ClassicSection = ClassDiffableSection<SectionIdentifierType, ItemIdentifierType>
    
    // MARK: - Properties
        
    private var image: [ClassicSection] = []
    
    private var tasks: [ClassicDiffableTask] = []
    
    var items: [ItemIdentifierType] {
        get {
            guard let section = section() else { return [] }
            return section.items
        }
        set {
            guard
                var section = section(),
                let sectionIndex = sectionIndex()
            else { return }
            
            tasks = [.reloadData]
            section.items = newValue
            
            image[sectionIndex] = section
        }
    }
    
    // MARK: - Public methods
    
    public mutating func willChange() {
        tasks = []
    }
    
    public mutating func appendSections(_ newValue: [SectionIdentifierType]) {
        let startIndex = image.count
        newValue.enumerated().forEach({ offset, identifier in
            tasks.append(.insertSection(index: startIndex + offset))
            
            let section = ClassicSection(identifier: identifier)
            image.append(section)
        })
    }
    
    public mutating func insertItem(_ identifier: ItemIdentifierType, at indexPath: IndexPath) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        tasks.append(.insertItem(indexPath: indexPath))
        section.items.append(identifier)
        
        image[sectionIndex] = section
    }
    
    
    public mutating func reloadItem(_ identifier: ItemIdentifierType, at indexPath: IndexPath) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        tasks.append(.reloadItem(indexPath: indexPath))
        
        let index = indexPath.item
        section.items.remove(at: index)
        section.items.insert(identifier, at: index)
        
        image[sectionIndex] = section
    }

    public mutating func deleteItem(_ identifier: ItemIdentifierType, at indexPath: IndexPath) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        tasks.append(.deleteItem(indexPath: indexPath))
        
        let index = indexPath.item
        section.items.remove(at: index)
        
        image[sectionIndex] = section
    }
    
    // MARK: - Private methods
    
    private func section(_ identifier: SectionIdentifierType? = nil) ->  ClassicSection? {
        if let result = image.filter({ $0.identifier == identifier }).first {
            return result
        } else if identifier == nil {
            return image.last
        } else {
            return nil
        }
    }
    
    private func sectionIndex(_ identifier: SectionIdentifierType? = nil) -> Int? {
        if identifier == nil && !image.isEmpty { return image.count - 1 }
        if let result = image.enumerated().filter({ $0.element.identifier == identifier }).first?.offset {
            return result
        }
        return nil
    }
    
    // MARK: - Data source
    
    var numberOfSections: Int {
        return image.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return image[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> ItemIdentifierType? {
        guard indexPath.section < image.count else { return nil }
        let section = image[indexPath.section]
        guard indexPath.item < section.items.count else { return nil }
        return section.items[indexPath.item]
    }
    
    // MARK: - Tasks
    
    func update(_ collectionView: UICollectionView?) {
        if tasks.count == 1 && tasks[0] == .reloadData {
            collectionView?.reloadData()
        } else {
            collectionView?.performBatchUpdates({
                tasks.forEach({ task in
                    switch task {
                    case .insertSection(let index): collectionView?.insertSections(IndexSet(integer: index))
                    case .reloadSection(let index): collectionView?.reloadSections(IndexSet(integer: index))
                    case .deleteSection(let index): collectionView?.deleteSections(IndexSet(integer: index))
                    case .insertItem(let path): collectionView?.insertItems(at: [path])
                    case .reloadItem(let path): collectionView?.reloadItems(at: [path])
                    case .deleteItem(let path): collectionView?.deleteItems(at: [path])
                    default: break
                    }
                })
            }, completion: nil)
        }
    }

}

fileprivate struct ClassDiffableSection<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    var identifier: SectionIdentifierType
    
    var items: [ItemIdentifierType] = []
    
}

public enum ClassicDiffableTask: Equatable {
    
    case insertItem(indexPath: IndexPath)
    
    case reloadItem(indexPath: IndexPath)
    
    case deleteItem(indexPath: IndexPath)
    
    case insertSection(index: Int)
    
    case deleteSection(index: Int)
    
    case reloadSection(index: Int)
    
    case reloadData
    
}
