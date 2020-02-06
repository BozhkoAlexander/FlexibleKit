//
//  FlexibleView.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FlexibleView: UIView {
    
    // MARK: - Subviews
    
    weak var collectionView: UICollectionView! = nil
    
    private func setupCollectionView(for vc: FlexibleViewController) {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .groupTableViewBackground
        }
        
        view.delegate = vc
        
        addSubview(view)
        collectionView = view
    }
    
    // MARK: - Life cycle
    
    init(for vc: FlexibleViewController) {
        super.init(frame: .zero)
        
        setupCollectionView(for: vc)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
