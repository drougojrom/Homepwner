//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 15/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    
    var itemStore: ItemStore!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create an instance of UITableViewCell with default appearence
        
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        
        // set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear at the table view
        
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
}
