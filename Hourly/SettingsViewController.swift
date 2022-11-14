//
//  SettingsViewController.swift
//  Hourly
//
//  Created by Anastasia Grosch on 11/13/22.
//

import UIKit

class SettingsViewController: UIViewController, UISearchBarDelegate {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var enableSwitch: UISwitch!
    @IBOutlet weak var arrow1: UIButton!
    @IBOutlet weak var arrow2: UIButton!
    @IBOutlet weak var arrow3: UIButton!
    @IBOutlet weak var arrow4: UIButton!
    @IBOutlet weak var arrow5: UIButton!
    
    
    var pay = [0.0, 0.0, 0.0, 0.0, 0.0]
    var jobName = ["", "", "", "", ""]
    var tmpWage = 0.0
    var tmpName = ""
    var tmpNum = 0
    var tmpRounding = false
    
    /* groups */
    private let group1Text: UILabel = {
        let group1 = UILabel()
        group1.font = .systemFont(ofSize: 16)
        group1.textColor = .lightGray
        group1.textAlignment = .left
        group1.text = "HOUR ROUNDING"
        return group1
    }()
    
    private let group2Text: UILabel = {
        let group2 = UILabel()
        group2.font = .systemFont(ofSize: 16)
        group2.textColor = .lightGray
        group2.textAlignment = .left
        group2.text = "ALL JOB INFO"
        return group2
    }()
    
    private let group3Text: UILabel = {
        let group3 = UILabel()
        group3.font = .systemFont(ofSize: 16)
        group3.textColor = .lightGray
        group3.textAlignment = .left
        group3.text = "RESET"
        return group3
    }()
    
    /* box borders */
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
    
    private let border3: UIView = {
        let box3 = UIView()
        box3.backgroundColor = .darkGray
        box3.layer.cornerRadius = 10
        return box3
    }()
    
    private let border4: UIView = {
        let box4 = UIView()
        box4.backgroundColor = .darkGray
        box4.layer.cornerRadius = 10
        return box4
    }()
    
    private let border5: UIView = {
        let box5 = UIView()
        box5.backgroundColor = .darkGray
        box5.layer.cornerRadius = 10
        return box5
    }()
    
    private let border6: UIView = {
        let box6 = UIView()
        box6.backgroundColor = .darkGray
        box6.layer.cornerRadius = 10
        return box6
    }()
    
    /* text options */
    private let enableText: UILabel = {
        let text1 = UILabel()
        text1.font = .systemFont(ofSize: 16)
        text1.textColor = .white
        text1.textAlignment = .left
        text1.text = "Enable Rounding"
        return text1
    }()
    
    private let job1Text: UILabel = {
        let job1 = UILabel()
        job1.font = .systemFont(ofSize: 16)
        job1.textColor = .white
        job1.textAlignment = .left
        job1.text = "Job 1"
        return job1
    }()
    
    private let job2Text: UILabel = {
        let job2 = UILabel()
        job2.font = .systemFont(ofSize: 16)
        job2.textColor = .white
        job2.textAlignment = .left
        job2.text = "Job 2"
        return job2
    }()
    
    private let job3Text: UILabel = {
        let job3 = UILabel()
        job3.font = .systemFont(ofSize: 16)
        job3.textColor = .white
        job3.textAlignment = .left
        job3.text = "Job 3"
        return job3
    }()
    
    private let job4Text: UILabel = {
        let job4 = UILabel()
        job4.font = .systemFont(ofSize: 16)
        job4.textColor = .white
        job4.textAlignment = .left
        job4.text = "Job 4"
        return job4
    }()
    
    private let job5Text: UILabel = {
        let job5 = UILabel()
        job5.font = .systemFont(ofSize: 16)
        job5.textColor = .white
        job5.textAlignment = .left
        job5.text = "Job 5"
        return job5
    }()
    
    private let clearJobs: UIButton = {
        let clear = UIButton()
        clear.titleLabel?.font = UIFont(name: "System", size: 16)
        clear.setTitleColor(.systemRed, for: .normal)
        clear.backgroundColor = .darkGray
        clear.layer.cornerRadius = 10
        clear.setTitle("DELETE ALL JOBS", for: .normal)
        return clear
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.title = "SETTINGS"
        searchBar.delegate = self
        
        ViewController().modifyPay(array: &pay)
        ViewController().modify(array: &jobName)
        ViewController().getRounding(Bool: &tmpRounding)
        enableSwitch.setOn(tmpRounding, animated: false)
        
        view.addSubview(border1)
        view.addSubview(border2)
        view.addSubview(border3)
        view.addSubview(border4)
        view.addSubview(border5)
        view.addSubview(border6)
        
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
        clearJobs.addTarget(self, action: #selector(clearButton(_sender:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        
        group1Text.frame = CGRect(x: 20, y: 180, width: 134, height: 20)
        group2Text.frame = CGRect(x: 20, y: 280, width: 134, height: 20)
        group3Text.frame = CGRect(x: 20, y: 580, width: 134, height: 20)
        
        border1.frame = CGRect(x: 20, y: 210, width: 335, height: 40)
        border2.frame = CGRect(x: 20, y: 310, width: 335, height: 40)
        border3.frame = CGRect(x: 20, y: 355, width: 335, height: 40)
        border4.frame = CGRect(x: 20, y: 400, width: 335, height: 40)
        border5.frame = CGRect(x: 20, y: 445, width: 335, height: 40)
        border6.frame = CGRect(x: 20, y: 490, width: 335, height: 40)
        
        enableText.frame = CGRect(x: 30, y: 220, width: 122, height: 20)
        job1Text.frame = CGRect(x: 30, y: 320, width: 122, height: 20)
        job2Text.frame = CGRect(x: 30, y: 365, width: 122, height: 20)
        job3Text.frame = CGRect(x: 30, y: 410, width: 122, height: 20)
        job4Text.frame = CGRect(x: 30, y: 455, width: 122, height: 20)
        job5Text.frame = CGRect(x: 30, y: 500, width: 122, height: 20)
        
        enableSwitch.frame = CGRect(x: 295, y: 215, width: 51, height: 31)
        arrow1.frame = CGRect(x: 305, y: 315, width: 40, height: 31)
        arrow2.frame = CGRect(x: 305, y: 360, width: 40, height: 31)
        arrow3.frame = CGRect(x: 305, y: 405, width: 40, height: 31)
        arrow4.frame = CGRect(x: 305, y: 450, width: 40, height: 31)
        arrow5.frame = CGRect(x: 305, y: 495, width: 40, height: 31)
        clearJobs.frame = CGRect(x: 20, y: 610, width: 335, height: 40)
    }

    @IBAction func goToJob1(_ sender: Any) {
        tmpName = jobName[0]
        tmpWage = pay[0]
        tmpNum = 1
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @IBAction func goToJob2(_ sender: Any) {
        tmpName = jobName[1]
        tmpWage = pay[1]
        tmpNum = 2
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @IBAction func goToJob3(_ sender: Any) {
        tmpName = jobName[2]
        tmpWage = pay[2]
        tmpNum = 3
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @IBAction func goToJob4(_ sender: Any) {
        tmpName = jobName[3]
        tmpWage = pay[3]
        tmpNum = 4
        performSegue(withIdentifier: "jobDetails", sender: self)
    }
    
    @IBAction func goToJob5(_ sender: Any) {
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
            ViewController().clearHours()
            self.tmpRounding = true
            self.saveRounding()
            self.enableSwitch.setOn(true, animated: true)
            
            ViewController().saveBoolFromTmp(array: &emptyBool)
            ViewController().saveNamesFromTmp(array: &emptyString)
            ViewController().savePayFromTmp(array: &emptyDouble)
            
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
