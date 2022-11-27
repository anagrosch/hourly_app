//
//  SettingsViewController.swift
//  Hourly
//
//  Created by Anastasia Grosch on 11/13/22.
//

import UIKit

class SettingsViewController: UIViewController, UISearchBarDelegate {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let jf = JobFunctions()
    
    var headerLine = UIView()
    var border1 = UIView()
    var border2 = UIView()
    var border3 = UIView()
    var border4 = UIView()
    var border5 = UIView()
    var border6 = UIView()
    var border7 = UIView()
    
    var enableText = UILabel()
    var group1Text = UILabel()
    var group2Text = UILabel()
    var group3Text = UILabel()
    var job1Text = UILabel()
    var job2Text = UILabel()
    var job3Text = UILabel()
    var job4Text = UILabel()
    var job5Text = UILabel()
    
   
    let arrow1 = UIButton()
    let arrow2 = UIButton()
    let arrow3 = UIButton()
    let arrow4 = UIButton()
    let arrow5 = UIButton()
    var clearJobs = UIButton()
    let enableSwitch = UISwitch(frame: CGRect(x: 30, y: 175, width: 122, height: 20))
    let arrowImage = UIImage(systemName: "chevron.right.circle")?.withTintColor(.arrow!, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 25, height: 25))
    
    var pay = [0.0, 0.0, 0.0, 0.0, 0.0]
    var jobName = ["", "", "", "", ""]
    var tmpWage = 0.0
    var tmpName = ""
    var tmpNum = 0
    var tmpRounding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.backgroundColor = .basic
        self.title = "SETTINGS"
        
        headerLine = jf.createLine()
        border1 = jf.createBorder()
        border2 = jf.createBorder()
        border3 = jf.createBorder()
        border4 = jf.createBorder()
        border5 = jf.createBorder()
        border6 = jf.createBorder()
        border7 = jf.createBorder()
        
        enableText = jf.createLabel(text: "Enable Rounding", color: .nonBasic!)
        group1Text = jf.createLabel(text: "HOUR ROUNDING", color: .arrow!)
        group2Text = jf.createLabel(text: "ALL JOB INFO", color: .arrow!)
        group3Text = jf.createLabel(text: "RESET", color: .arrow!)
        job1Text = jf.createLabel(text: "Job 1", color: .nonBasic!)
        job2Text = jf.createLabel(text: "Job 2", color: .nonBasic!)
        job3Text = jf.createLabel(text: "Job 3", color: .nonBasic!)
        job4Text = jf.createLabel(text: "Job 4", color: .nonBasic!)
        job5Text = jf.createLabel(text: "Job 5", color: .nonBasic!)
        
        arrow1.setImage(arrowImage, for: .normal)
        arrow2.setImage(arrowImage, for: .normal)
        arrow3.setImage(arrowImage, for: .normal)
        arrow4.setImage(arrowImage, for: .normal)
        arrow5.setImage(arrowImage, for: .normal)
        
        clearJobs = jf.createButton(textColor: .systemRed, buttonColor: .border!, corner: 10, text: "DELETE ALL JOBS")
        
        jf.modifyPay(array: &pay)
        jf.modify(array: &jobName)
        jf.getRounding(Bool: &tmpRounding)
        enableSwitch.setOn(tmpRounding, animated: false)
        
        view.addSubview(border1)
        view.addSubview(border2)
        view.addSubview(border3)
        view.addSubview(border4)
        view.addSubview(border5)
        view.addSubview(border6)
        view.addSubview(border7)
        view.addSubview(headerLine)
        
        view.addSubview(group1Text)
        view.addSubview(group2Text)
        view.addSubview(group3Text)
        
        view.addSubview(enableText)
        view.addSubview(job1Text)
        view.addSubview(job2Text)
        view.addSubview(job3Text)
        view.addSubview(job4Text)
        view.addSubview(job5Text)
        
        view.addSubview(enableSwitch)
        view.addSubview(arrow1)
        view.addSubview(arrow2)
        view.addSubview(arrow3)
        view.addSubview(arrow4)
        view.addSubview(arrow5)
        view.addSubview(clearJobs)
        
        enableSwitch.addTarget(self, action: #selector(switchRound(_sender:)), for: .touchUpInside)
        arrow1.addTarget(self, action: #selector(goToJob1(_:)), for: .touchUpInside)
        arrow2.addTarget(self, action: #selector(goToJob2(_:)), for: .touchUpInside)
        arrow3.addTarget(self, action: #selector(goToJob3(_:)), for: .touchUpInside)
        arrow4.addTarget(self, action: #selector(goToJob4(_:)), for: .touchUpInside)
        arrow5.addTarget(self, action: #selector(goToJob5(_:)), for: .touchUpInside)
        clearJobs.addTarget(self, action: #selector(clearButton(_sender:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        
        group1Text.frame = CGRect(x: 20, y: 135, width: 134, height: 20)
        group2Text.frame = CGRect(x: 20, y: 235, width: 134, height: 20)
        group3Text.frame = CGRect(x: 20, y: 535, width: 134, height: 20)
        
        border1.frame = CGRect(x: 20, y: 165, width: 335, height: 40)
        border2.frame = CGRect(x: 20, y: 265, width: 335, height: 40)
        border3.frame = CGRect(x: 20, y: 265, width: 335, height: 40)
        border4.frame = CGRect(x: 20, y: 310, width: 335, height: 40)
        border5.frame = CGRect(x: 20, y: 355, width: 335, height: 40)
        border6.frame = CGRect(x: 20, y: 400, width: 335, height: 40)
        border7.frame = CGRect(x: 20, y: 445, width: 335, height: 40)
        headerLine.frame = CGRect(x: 0, y: 100, width: 375, height: 2)
        
        enableText.frame = CGRect(x: 30, y: 175, width: 122, height: 20)
        job1Text.frame = CGRect(x: 30, y: 275, width: 122, height: 20)
        job2Text.frame = CGRect(x: 30, y: 320, width: 122, height: 20)
        job3Text.frame = CGRect(x: 30, y: 365, width: 122, height: 20)
        job4Text.frame = CGRect(x: 30, y: 410, width: 122, height: 20)
        job5Text.frame = CGRect(x: 30, y: 455, width: 122, height: 20)
        
        enableSwitch.frame = CGRect(x: 295, y: 170, width: 51, height: 31)
        arrow1.frame = CGRect(x: 305, y: 265, width: 40, height: 40)
        arrow2.frame = CGRect(x: 305, y: 310, width: 40, height: 40)
        arrow3.frame = CGRect(x: 305, y: 355, width: 40, height: 40)
        arrow4.frame = CGRect(x: 305, y: 400, width: 40, height: 40)
        arrow5.frame = CGRect(x: 305, y: 445, width: 40, height: 40)
        clearJobs.frame = CGRect(x: 20, y: 565, width: 335, height: 40)
    }

    @objc func goToJob1(_ sender: UIButton!) {
        tmpName = jobName[0]
        tmpWage = pay[0]
        tmpNum = 1
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @objc func goToJob2(_ sender: UIButton!) {
        tmpName = jobName[1]
        tmpWage = pay[1]
        tmpNum = 2
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @objc func goToJob3(_ sender: UIButton!) {
        tmpName = jobName[2]
        tmpWage = pay[2]
        tmpNum = 3
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @objc func goToJob4(_ sender: UIButton!) {
        tmpName = jobName[3]
        tmpWage = pay[3]
        tmpNum = 4
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @objc func goToJob5(_ sender: UIButton!) {
        tmpName = jobName[4]
        tmpWage = pay[4]
        tmpNum = 5
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @objc func clearButton(_sender: UIButton!) {
        var emptyBool = [true, true, true, true, true]
        var emptyString = ["", "", "", "", ""]
        var emptyDouble = [0.0, 0.0, 0.0, 0.0, 0.0]
        let alert = UIAlertController(title: "Reset Jobs?", message: "Are you sure you want to delete all jobs and hours?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.jf.clearHours()
            self.tmpRounding = true
            self.saveRounding()
            self.enableSwitch.setOn(true, animated: true)
            
            self.jf.saveBoolFromTmp(array: &emptyBool)
            self.jf.saveNamesFromTmp(array: &emptyString)
            self.jf.savePayFromTmp(array: &emptyDouble)
            
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    @objc func switchRound(_sender: UISwitch!) {
        if enableSwitch.isOn { tmpRounding = true }
        else { tmpRounding = false }
        saveRounding()
    }
    
    func saveRounding() {
        let item = RoundingOption(context: context)
        item.rounding = tmpRounding
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? JobDetailsViewController {
            vc.job = self.tmpName
            vc.wage = self.tmpWage
            vc.jobNum = self.tmpNum
        }
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
