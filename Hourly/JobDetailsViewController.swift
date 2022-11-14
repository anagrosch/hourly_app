//
//  JobDetailsViewController.swift
//  Hourly
//
//  Page showing job info from job button in settings
//
//  Created by Anastasia Grosch on 11/13/22.
//

import UIKit

class JobDetailsViewController: UIViewController {

    var jobNum = 0
    var job = "N/A"
    var wage = 0.0
    var tmpJob = ["", "", "", "", ""]
    var tmpWage = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wageLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var wageField: UITextField!
    
    private let border1: UIView = {
        let box1 = UIView()
        box1.backgroundColor = .darkGray
        box1.layer.cornerRadius = 10
        return box1
    }()
    
    private let border2: UIView = {
        let box2 = UIView()
        box2.backgroundColor = .darkGray
        box2.layer.cornerRadius = 10
        return box2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Job " + String(jobNum)
        
        view.addSubview(border1)
        view.addSubview(border2)
        view.sendSubviewToBack(border1)
        view.sendSubviewToBack(border2)
        
        titleLabel.numberOfLines = 0
        titleLabel.text = "Job Title:"
        wageLabel.numberOfLines = 0
        wageLabel.text = "Hourly Wage: $"
        
        AddButtonViewController().addDoneButtonOnNumpad(textField: titleField)
        titleField.alpha = 0.3
        titleField.text = job
        
        wageField.keyboardType = .numberPad
        AddButtonViewController().addDoneButtonOnNumpad(textField: wageField)
        wageField.alpha = 0.3
        wageField.text = String(wage)
        
        if titleField.text == "" {
            wageField.isUserInteractionEnabled = false
            titleField.addTarget(self, action: #selector(emptyWarning), for: .editingChanged)
        }
        else {
            wageField.addTarget(self, action: #selector(wageChanged), for: .editingChanged)
            titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        border1.frame = CGRect(x: 20, y: 125, width: 335, height: 40)
        border2.frame = CGRect(x: 20, y: 185, width: 335, height: 40)
    }
    
    @objc func titleChanged() {
        ViewController().modify(array: &tmpJob)
        tmpJob[jobNum - 1] = titleField.text ?? ""
        ViewController().saveNamesFromTmp(array: &tmpJob)
    }
    
    @objc func wageChanged() {
        ViewController().modifyPay(array: &tmpWage)
        tmpWage[jobNum - 1] = Double(wageField.text!) ?? 0.0
        ViewController().savePayFromTmp(array: &tmpWage)
    }
    
    @objc func emptyWarning() {
        let alert = UIAlertController(title: "Empty Job", message: "This job does not exist. To add a job, use the ADD JOB button on the home page.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
}
