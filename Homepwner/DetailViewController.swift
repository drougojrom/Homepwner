//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 19/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
       let formatter = NSDateFormatter()
       formatter.dateStyle = .MediumStyle
       formatter.timeStyle = .NoStyle
       return formatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // clear first responder
        view.endEditing(true)
        
        // save changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText){
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
}
