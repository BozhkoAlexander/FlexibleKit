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
    
    var dataSource: FlexibleDataSource<Item>!
    
    var model = FlexibleModel()
    
    private var flexibleView: FlexibleView! { return view as? FlexibleView }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = FlexibleView(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flexible page"
        
        dataSource = FlexibleDataSource<Item>()
        dataSource.start(with: flexibleView.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueReusableCell(withReuseIdentifier: item.type.cellId, for: indexPath)
        }
        dataSource.register(cells: ItemType.cellsInfo)
        model.load()
        dataSource.update(model.items, animated: false)
    }
    
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FlexibleCell else { return }
        cell.willDisplay(model.items[indexPath.item])
    }

}

