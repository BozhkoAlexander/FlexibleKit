//
//  ClassicDiffableSnapshot.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

public struct ClassicDiffableSnapshot<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    // MARK: - Properties
    
    private var image: [ClassDiffableSection<SectionIdentifierType, ItemIdentifierType>] = []
    
    // MARK: - Public methods
    
    public mutating func appendSections(_ newValue: [SectionIdentifierType]) {
        newValue.forEach({
            let section = ClassDiffableSection<SectionIdentifierType, ItemIdentifierType>(identifier: $0)
            image.append(section)
        })
        
    }
    
    public mutating func appendItems(_ newValue: [ItemIdentifierType]) {
        guard var section = image.first else { return }
        section.items.append(contentsOf: newValue)
        image[0] = section
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

}

fileprivate struct ClassDiffableSection<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    var identifier: SectionIdentifierType
    
    var items: [ItemIdentifierType] = []
    
}
