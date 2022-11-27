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
    
    let jf = JobFunctions()
    
    var heading = UILabel()
    var jobTitleTextField = UITextField()
    var hourlyWageTextField = UITextField()
    var addJobButton = UIButton()
    
    var boolArray = [true, true, true, true, true]
    var positionArray = ["", "", "", "", ""]
    var wages = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customPurple2
        
        heading = jf.createHeading(text: "ADD NEW JOB", color: .white)
        jobTitleTextField = jf.createTextField(color: .customPurple!, corner: 5, textColor: .white, align: .center, tmpText: "Enter job title")
        hourlyWageTextField = jf.createTextField(color: .customPurple!, corner: 5, textColor: .white, align: .center, tmpText: "Enter hourly wage")
        addJobButton = jf.createButton(textColor: .white, buttonColor: .customPurple!, corner: 5, text: "ADD JOB")
        
        view.addSubview(heading)
        view.addSubview(jobTitleTextField)
        view.addSubview(hourlyWageTextField)
        view.addSubview(addJobButton)
        
        hourlyWageTextField.keyboardType = .numberPad
        addDoneButtonOnNumpad(textField: jobTitleTextField)
        addDoneButtonOnNumpad(textField: hourlyWageTextField)

        addJobButton.addTarget(self, action: #selector(addJobPressed(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        heading.frame = CGRect(x: 30, y: 80, width: 315, height: 40)
        jobTitleTextField.frame = CGRect(x: 30, y: 210, width: 315, height: 34)
        hourlyWageTextField.frame = CGRect(x: 30, y: 285, width: 315, height: 34)
        addJobButton.frame = CGRect(x: 30, y: 425, width: 315, height: 50)
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
    
    @objc func addJobPressed(_ sender: UIButton!) {
        
        if jobTitleTextField.text == "" || hourlyWageTextField.text == "" {
            let alert = UIAlertController(title: "Missing Information", message: "Please enter both job title and hourly wage. Or click cancel to exit.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true)
        }
        else {
            jf.modifyPay(array: &wages)
            jf.modify(array: &positionArray)
            jf.modifyBool(array: &boolArray)
            
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
            jf.savePayFromTmp(array: &wages)
            jf.saveNamesFromTmp(array: &positionArray)
            jf.saveBoolFromTmp(array: &boolArray)
            
            performSegue(withIdentifier: "returnHome", sender: self)
        }
    }
}
