//
//  FlexibleLayout.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class FlexibleLayout<ItemIdentifierType>: NSObject where ItemIdentifierType: FlexibleProvider {
    
    public typealias ClassicSnapshot = ClassicDiffableSnapshot<Section, ItemIdentifierType>
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    public func update(_ collectionView: UICollectionView?, animated: Bool, snapshot: ClassicSnapshot) {
        guard let view = collectionView else { return }
        let layout = classic(snapshot)
        view.setCollectionViewLayout(layout, animated: animated)
    }
    
    private func classic(_ snapshot: ClassicSnapshot) -> ClassicLayout {
        let items = snapshot.items.filter({ $0.isSurface }).map({ $0.classicItem })
        
        let groupSize = ClassicLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = ClassicLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        
        let section = ClassicLayoutSection(group: group)
        return ClassicLayout(section: section)
    }

}
