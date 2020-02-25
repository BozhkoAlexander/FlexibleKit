//
//  FlexibleReusableView.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 25.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FlexibleReusableView: UICollectionReusableView {
    
    // MARK: - Subviews
    
    weak var textLabel: UILabel! = nil
    
    private func setupTextLabel() {
        let label = UILabel()
        
        addSubview(label)
        textLabel = label
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextLabel()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Content
    
    func willDisplay(_ item: FlexibleSupplementaryItem) {
        textLabel.text = item.text
        textLabel.font = item.font
        setNeedsLayout()
    }
        
}
