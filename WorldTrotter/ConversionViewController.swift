//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Matthew Compton on 10/19/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String
        ) -> Bool {

            let setAllowed = NSCharacterSet(charactersInString: "0123456789.")
            let setAttempted = NSCharacterSet(charactersInString: string)
            let valid: Bool = setAllowed.isSupersetOfSet(setAttempted)
            if (!valid) {
                return false;
            }
            
            let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
            let replacementTextHasDecimalSeparator = string.rangeOfString(".")
            if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
                let split = string.characters.split(".").count
                print(textField.text?.characters.count)
                print(range.length)
                if  split == 2 && range.location == 0 && range.length == textField.text?.characters.count {
                    return true
                }
                return false
            }
            
            return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded.")
    }
    
}