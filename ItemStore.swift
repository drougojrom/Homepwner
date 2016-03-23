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
    
    // URL for reading and writing files
    let itemsArchiveURL : NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDerictory = documentsDirectories.first!
        return documentDerictory.URLByAppendingPathComponent("items.archive")
    }()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item){
        if let index = allItems.indexOf(item){
            allItems.removeAtIndex(index)
        }
    }
    
    func moveRowAtIndex(fromIndex:Int , toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // remove item from the array
        allItems.removeAtIndex(fromIndex)
        
        // insert an item in array on new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    
    func saveChanges()-> Bool{
        print("Saving items to \(itemsArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemsArchiveURL.path!)
    }
    
    init(){
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemsArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
}