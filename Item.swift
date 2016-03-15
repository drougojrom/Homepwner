//
//  Item.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 15/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String
    var valueInDollards: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init (name: String, serialNumber: String?, valueInDollars: Int){
        self.name = name
        self.serialNumber = serialNumber
        self.valueInDollards = valueInDollars
        self.dateCreated = NSDate()
        
        super.init()
    }
    
}
