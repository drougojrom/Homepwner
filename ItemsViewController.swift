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
    
    @IBAction func addNewItem(sender: AnyObject){
    
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject){
        // if you are currently in editing mode
        
        if editing {
            // change the text of a button to inform user
            sender.setTitle("Editing", forState: .Normal)
            
            // turn off editing mode
            setEditing(false, animated: true)
        } else {
            // change the text to inform user
            sender.setTitle("Done", forState: .Normal)
            
            // enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // create a new recycle cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear at the table view
        
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
}
