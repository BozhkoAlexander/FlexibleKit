//
//  FlexibleViewController.swift
//  FlexibleKit
//
//  Created by BozhkoAlexander on 02/06/2020.
//  Copyright (c) 2020 BozhkoAlexander. All rights reserved.
//

import UIKit
import FlexibleKit

class FlexibleViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    var dataSource: FlexibleDataSource<FlexibleModel, Item>!
    
    var model = FlexibleModel()
    
    private var flexibleView: FlexibleView! { return view as? FlexibleView }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = FlexibleView(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flexible page"
        
        dataSource = FlexibleDataSource<FlexibleModel, Item>()
        dataSource.start(with: flexibleView.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueReusableCell(withReuseIdentifier: item.type.cellId, for: indexPath)
        }
        dataSource.appendSection(model) { (collectionView, kind, indexPath, model) -> UICollectionReusableView? in
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FlexibleModel.viewId(for: kind), for: indexPath)
        }
        dataSource.register(cells: ItemType.cellsInfo)
        dataSource.register(views: FlexibleModel.viewsInfo)
        model.load()
        dataSource.reloadData(model.flatItems)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.update()
        }
    }
    
    func update() {
        let index = 4
        let path = IndexPath(item: index, section: 0)
        let item = model.items[index]
        model.items.remove(at: index)
        
        dataSource.willChangeContent()
        dataSource.changeContent(item, at: path, for: .delete)
        dataSource.didChangeContent(model.flatItems, animated: true)
    }
    
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FlexibleCell else { return }
        cell.willDisplay(model.flatItems[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? FlexibleReusableView else { return }
        if elementKind == UICollectionView.elementKindSectionHeader {
            view.willDisplay(model.header)
        } else {
            view.willDisplay(model.footer)
        }
    }

}

