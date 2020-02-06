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
    
    var dataSource: FlexibleDataSource<FlexibleItem>!
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = FlexibleView(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = FlexibleDataSource<FlexibleItem>()
    }

}

