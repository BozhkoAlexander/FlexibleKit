//
//  FlexibleCell.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FlexibleCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    weak var textLabel: UILabel! = nil
    
    private func setupTextLabel() {
        let label = UILabel()
        
        contentView.addSubview(label)
        textLabel = label
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
        
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func willDisplay(_ item: Item) {
        if !isLayoutSetUp { setupLayout() }
        
        textLabel.text = item.title
        
        layoutIfNeeded()
    }
    
    // MARK: - Layout
    
    internal var isLayoutSetUp = false
    
    internal func setupLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        isLayoutSetUp = true
    }
    
}
