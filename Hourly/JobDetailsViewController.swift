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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wageLabel: UILabel!
    
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
        titleLabel.text = "Job Title: " + job
        wageLabel.numberOfLines = 0
        wageLabel.text = "Hourly Wage: $" + String(wage)
    }
    
    override func viewDidLayoutSubviews() {
        border1.frame = CGRect(x: 20, y: 125, width: 335, height: 40)
        border2.frame = CGRect(x: 20, y: 185, width: 335, height: 40)
    }
    
    
}
