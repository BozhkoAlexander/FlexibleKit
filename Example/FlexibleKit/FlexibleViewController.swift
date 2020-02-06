//
//  FlexibleViewController.swift
//  FlexibleKit
//
//  Created by BozhkoAlexander on 02/06/2020.
//  Copyright (c) 2020 BozhkoAlexander. All rights reserved.
//

import UIKit

class FlexibleViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = FlexibleView(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

