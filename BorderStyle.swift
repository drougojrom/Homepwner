//
//  BorderStyle.swift
//  Homepwner
//
//  Created by Roman Ustiantcev on 21/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class BorderStyle: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = UITextBorderStyle.Bezel
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = UITextBorderStyle.RoundedRect
        return true
    }
    
}
