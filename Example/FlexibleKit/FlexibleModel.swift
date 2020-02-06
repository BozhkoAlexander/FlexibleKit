//
//  FlexibleModel.swift
//  FlexibleKit_Example
//
//  Created by Alexander Bozhko on 06.02.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FlexibleModel: NSObject {
    
    var items: [Item] = []
        
    public func load() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        var json: Any? = nil
        do {
            let data = try Data(contentsOf: url)
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {}
        
        update(json)
    }
    
    private func update(_ value: Any?) {
        guard let json = value as? Array<Any> else {
            items = []
            return
        }
        items = json.map({ Item($0) })
    }

}
