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

    let jf = JobFunctions()
    
    var headerLine = UIView()
    var border1 = UIView()
    var border2  = UIView()
    var titleLabel = UILabel()
    var wageLabel = UILabel()
    var titleField = UITextField()
    var wageField = UITextField()
    var clearHours = UIButton()
    
    var jobNum = 0
    var job = ""
    var wage = 0.0
    var tmpJob = ["", "", "", "", ""]
    var tmpWage = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .basic

        self.title = "Job " + String(jobNum)
        headerLine = jf.createLine()
        border1 = jf.createBorder()
        border2 = jf.createBorder()
        titleLabel = jf.createLabel(text: "Job Title", color: .nonBasic!)
        wageLabel = jf.createLabel(text: "Hourly Wage:   $", color: .nonBasic!)
        titleField = jf.createTextField(alpha: 0.6, color: .lightGray, corner: 5, align: .left, indent: 10, text: job)
        wageField = jf.createTextField(alpha: 0.6, color: .lightGray, corner: 5, align: .left, indent: 10, text: String(wage))
        clearHours = jf.createButton(textColor: .systemRed, buttonColor: .border!, corner: 10, text: "CLEAR HOURS")
        
        view.addSubview(headerLine)
        view.addSubview(border1)
        view.addSubview(border2)
        view.addSubview(titleLabel)
        view.addSubview(wageLabel)
        view.addSubview(titleField)
        view.addSubview(wageField)
        view.addSubview(clearHours)
        view.sendSubviewToBack(border1)
        view.sendSubviewToBack(border2)
        
        wageField.keyboardType = .numberPad
        AddButtonViewController().addDoneButtonOnNumpad(textField: titleField)
        AddButtonViewController().addDoneButtonOnNumpad(textField: wageField)
        
        if titleField.text == "" {
            wageField.isUserInteractionEnabled = false
            titleField.addTarget(self, action: #selector(emptyWarning), for: .editingChanged)
            clearHours.isEnabled = false
            clearHours.alpha = 0.3
        }
        else {
            wageField.addTarget(self, action: #selector(wageChanged), for: .editingChanged)
            titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
            clearHours.addTarget(self, action: #selector(clearJobHours), for: .touchUpInside)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        headerLine.frame = CGRect(x: 0, y: 100, width: 375, height: 2)
        border1.frame = CGRect(x: 20, y: 125, width: 335, height: 40)
        border2.frame = CGRect(x: 20, y: 185, width: 335, height: 40)
        titleLabel.frame = CGRect(x: 30, y: 125, width: 150, height: 40)
        wageLabel.frame =  CGRect(x: 30, y: 185, width: 150, height: 40)
        titleField.frame = CGRect(x: 159, y: 128, width: 180, height: 33)
        wageField.frame = CGRect(x: 159, y: 188, width: 180, height: 33)
        clearHours.frame = CGRect(x: 20, y: 300, width: 335, height: 40)
    }
    
    @objc func titleChanged() {
        jf.modify(array: &tmpJob)
        tmpJob[jobNum - 1] = titleField.text ?? ""
        jf.saveNamesFromTmp(array: &tmpJob)
    }
    
    @objc func wageChanged() {
        jf.modifyPay(array: &tmpWage)
        tmpWage[jobNum - 1] = Double(wageField.text!) ?? 0.0
        jf.savePayFromTmp(array: &tmpWage)
    }
    
    @objc func emptyWarning() {
        let alert = UIAlertController(title: "Empty Job", message: "This job does not exist. To add a job, use the ADD JOB button on the home page.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    @objc func clearJobHours() {
        let alert = UIAlertController(title: "Clear Hours Data?", message: "Clicking YES will reset the hours of this job only.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            if self.jobNum == 1 { self.jf.save1HoursFromTmp(array: &self.jf.clearAll) }
            else if self.jobNum == 2 { self.jf.save2HoursFromTmp(array: &self.jf.clearAll) }
            else if self.jobNum == 3 { self.jf.save3HoursFromTmp(array: &self.jf.clearAll) }
            else if self.jobNum == 4 { self.jf.save4HoursFromTmp(array: &self.jf.clearAll) }
            else if self.jobNum == 5 { self.jf.save5HoursFromTmp(array: &self.jf.clearAll) }
            
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
}

extension UITextField {
    func setPadding(left: CGFloat) {
        setLeftPadding(left)
    }

    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
