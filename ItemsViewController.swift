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
        
        // create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // figure out where is that item in the array
        
        if let index = itemStore.allItems.indexOf(newItem){
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // insert this row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    
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
        
        let valueInDollarsText = "$\(item.valueInDollars)"
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = valueInDollarsText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // if the table view is asking to commit a delete command
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                
                (action) -> Void in
                // remove the item from the store
                self.itemStore.removeItem(item)
                // also remove that row
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            })
            ac.addAction(deleteAction)
            
            // present the alert controller
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // update a model
        itemStore.moveRowAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}
