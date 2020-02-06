//
//  FlexibleLayout.swift
//  FlexibleKit
//
//  Created by Alexander Bozhko on 06.02.2020.
//

import UIKit

open class FlexibleLayout<ItemIdentifierType>: NSObject where ItemIdentifierType: FlexibleProvider {
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    public func update(_ collectionView: UICollectionView?, animated: Bool, items: Array<ItemIdentifierType>) {
        guard let view = collectionView else { return }
        let layout: UICollectionViewLayout
        if #available(iOS 13.0, *) {
            layout = modern(items)
        } else {
            layout = classic()
        }
        
        view.setCollectionViewLayout(layout, animated: animated)
    }
    
    @available(iOS 13.0, *)
    private func modern(_ providers: Array<ItemIdentifierType>) -> UICollectionViewCompositionalLayout {
        let items = providers.map({ $0.modernItem })
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func classic() -> ClassicLayout {
        return ClassicLayout()
    }

}
