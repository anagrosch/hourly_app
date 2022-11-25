//
//  AddButtonViewController.swift
//  Hourly
//
//  Page to add new job information
//
//  Created by Anastasia Grosch on 3/14/22.
//

import UIKit

class AddButtonViewController: UIViewController {
    
    let jobFunc = JobFunctions()
    
    var boolArray = [true, true, true, true, true]
    var positionArray = ["", "", "", "", ""]
    var wages = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var hourlyWageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourlyWageTextField.keyboardType = .numberPad
        addDoneButtonOnNumpad(textField: jobTitleTextField)
        addDoneButtonOnNumpad(textField: hourlyWageTextField)

    }

    func addDoneButtonOnNumpad(textField: UITextField) {
            let keypadToolbar: UIToolbar = UIToolbar()
            
            // add a done button to the numberpad
            keypadToolbar.items=[
                UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            ]
            keypadToolbar.sizeToFit()
            // add a toolbar with a done button above the number pad
            textField.inputAccessoryView = keypadToolbar
    }
    
    @IBAction func addJobPressed(_ sender: Any) {
        
        if jobTitleTextField.text == "" || hourlyWageTextField.text == "" {
            let alert = UIAlertController(title: "Missing Information", message: "Please enter both job title and hourly wage. Or click cancel to exit.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true)
        }
        else {
            jobFunc.modifyPay(array: &wages)
            jobFunc.modify(array: &positionArray)
            jobFunc.modifyBool(array: &boolArray)
            
            if self.positionArray[0] == "" {
                self.positionArray[0] = jobTitleTextField.text!
                self.wages[0] = Double(hourlyWageTextField.text!)!
                self.boolArray[0] = false
            } else if self.positionArray[1] == "" {
                self.positionArray[1] = jobTitleTextField.text!
                self.wages[1] = Double(hourlyWageTextField.text!)!
                self.boolArray[1] = false
            } else if self.positionArray[2] == "" {
                self.positionArray[2] = jobTitleTextField.text!
                self.wages[2] = Double(hourlyWageTextField.text!)!
                self.boolArray[2] = false
            } else if self.positionArray[3] == "" {
                self.positionArray[3] = jobTitleTextField.text!
                self.wages[3] = Double(hourlyWageTextField.text!)!
                self.boolArray[3] = false
            } else if self.positionArray[4] == "" {
                self.positionArray[4] = jobTitleTextField.text!
                self.wages[4] = Double(hourlyWageTextField.text!)!
                self.boolArray[4] = false
            }
            jobFunc.savePayFromTmp(array: &wages)
            jobFunc.saveNamesFromTmp(array: &positionArray)
            jobFunc.saveBoolFromTmp(array: &boolArray)
            
            performSegue(withIdentifier: "returnHome", sender: self)
        }
    }
}
