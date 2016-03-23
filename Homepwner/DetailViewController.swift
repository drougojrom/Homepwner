//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 19/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
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
        
        // get the item key
        let key = item.itemKey
        
        // if there is an associated image, show it
        let imageToDisplay = imageStore.imageForKey(key)
        imageView.image = imageToDisplay
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
    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // add crossHair
        let imageCrossHair = UIImage(named: "crossHair.png")
        let crossHairImageView = UIImageView(image: imageCrossHair)
        crossHairImageView.frame = CGRectMake(0, 0, 50, 50)
        let tempView = imagePicker.view
        crossHairImageView.center = tempView.center
        tempView.addSubview(crossHairImageView)
        
        // if your device has a camera, use it
        // otherwise just pick an image from library
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        // place imagePicker on the screen
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // get picked image from into dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        // store the image in the imageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // put that image on the screen in the image view
        imageView.image = image
        
        // take image picker off the screen -
        // must call this dismiss method
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func deleteImage(sender: UIBarButtonItem) {
        imageView.image = nil
    }
    
}
