//
//  ItemStore.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 15/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    init(){
        for _ in 0..<5 {
            createItem()
        }
    }
    
}