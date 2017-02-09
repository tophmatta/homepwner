//
//  CustomUITextField.swift
//  Homepwner
//
//  Created by Toph Matta on 1/24/17.
//  Copyright © 2017 Toph. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("return from custom tf")
        
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        print("It worked 1")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        print("It worked 2")
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .line
        
        print("in override BFR")
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .roundedRect
        
        print("in override RFR")
        
        return true
    }
    
}
