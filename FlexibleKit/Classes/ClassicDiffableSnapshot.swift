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
    
    // MARK: - Public methods
    
    public mutating func appendSections(_ newValue: [SectionIdentifierType]) {
        let startIndex = image.count
        newValue.enumerated().forEach({ offset, identifier in
            tasks.append(.insertSection(index: startIndex + offset))
            
            let section = ClassicSection(identifier: identifier)
            image.append(section)
        })
    }
    
    public mutating func appendItems(_ identifiers: [ItemIdentifierType], toSection sectionIdentifier: SectionIdentifierType? = nil) {
        guard
            var section = section(sectionIdentifier),
            let sectionIndex = sectionIndex(sectionIdentifier)
        else { return }
        
        let startIndex = section.items.count
        identifiers.enumerated().forEach({ (offset, identifier) in
            let indexPath = IndexPath(item: startIndex + offset, section: sectionIndex)
            tasks.append(.insertItem(indexPath: indexPath))
        })
        section.items.append(contentsOf: identifiers)
        
        image[sectionIndex] = section
    }

    public mutating func insertItems(_ identifiers: [ItemIdentifierType], beforeItem beforeIdentifier: ItemIdentifierType) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        if let startIndex = section.items.firstIndex(where: { $0 == beforeIdentifier }) {
            identifiers.enumerated().forEach({ (offset, identifier) in
                let indexPath = IndexPath(item: startIndex + offset, section: sectionIndex)
                tasks.append(.insertItem(indexPath: indexPath))
            })
            
            section.items.insert(contentsOf: identifiers, at: startIndex)
        } else {
            appendItems(identifiers)
        }
        
        image[sectionIndex] = section
    }

    public mutating func insertItems(_ identifiers: [ItemIdentifierType], afterItem afterIdentifier: ItemIdentifierType) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        if var startIndex = section.items.firstIndex(where: { $0 == afterIdentifier }) {
            startIndex += 1
            identifiers.enumerated().forEach({ (offset, identifier) in
                let indexPath = IndexPath(item: startIndex + offset, section: sectionIndex)
                tasks.append(.insertItem(indexPath: indexPath))
            })
            
            section.items.insert(contentsOf: identifiers, at: startIndex)
        } else {
            appendItems(identifiers)
        }
        
        image[sectionIndex] = section
    }

    public mutating func deleteItems(_ identifiers: [ItemIdentifierType]) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        identifiers.forEach({ identifier in
            if let index = section.items.firstIndex(where: { $0 == identifier }) {
                let indexPath = IndexPath(item: index, section: sectionIndex)
                tasks.append(.deleteItem(indexPath: indexPath))
                section.items.remove(at: index)
            }
        })
        
        image[sectionIndex] = section
    }

    public mutating func deleteAllItems() {
        tasks = [.reloadData]
        image = []
    }

    public mutating func reloadItems(_ identifiers: [ItemIdentifierType]) {
        guard
            var section = section(),
            let sectionIndex = sectionIndex()
        else { return }
        
        identifiers.forEach({ identifier in
            if let index = section.items.firstIndex(where: { $0 == identifier }) {
                let indexPath = IndexPath(item: index, section: sectionIndex)
                tasks.append(.deleteItem(indexPath: indexPath))
                section.items.remove(at: index)
            }
        })
        
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
        if identifier == nil && !image.isEmpty { return image.count }
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
    
    mutating func update(_ collectionView: UICollectionView?) {
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
                    case .updateItem(let path): collectionView?.reloadItems(at: [path])
                    case .deleteItem(let path): collectionView?.deleteItems(at: [path])
                    default: break
                    }
                })
            }, completion: nil)
        }
        
        tasks = []
    }

}

fileprivate struct ClassDiffableSection<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    var identifier: SectionIdentifierType
    
    var items: [ItemIdentifierType] = []
    
}

public enum ClassicDiffableTask: Equatable {
    
    case insertItem(indexPath: IndexPath)
    
    case updateItem(indexPath: IndexPath)
    
    case deleteItem(indexPath: IndexPath)
    
    case insertSection(index: Int)
    
    case deleteSection(index: Int)
    
    case reloadSection(index: Int)
    
    case reloadData
    
}
