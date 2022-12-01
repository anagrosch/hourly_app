//
//  TotalHoursViewController.swift
//  Hourly
//
//  Page for showing the measured hours of the week for
//  each job
//
//  Created by Anastasia Grosch on 3/18/22.
//

import UIKit

class TotalHoursViewController: UIViewController {

    let jf = JobFunctions()
    
    var line1 = UIView()
    var line2 = UIView()
    var line3 = UIView()
    var line4 = UIView()
    var backgroundColor = UIView()
    
    let myText2: String
    let monHours: String
    let tuesHours: String
    let wedHours: String
    let thurHours: String
    let friHours: String
    let satHours: String
    let sunHours: String
    let totalHours: String
    
    var textView2 = UILabel()
    var monLabel = UILabel()
    var tuesLabel = UILabel()
    var wedLabel = UILabel()
    var thurLabel = UILabel()
    var friLabel = UILabel()
    var satLabel = UILabel()
    var sunLabel = UILabel()
    var totalLabel = UILabel()
    
    var monTitle = UILabel()
    var tuesTitle = UILabel()
    var wedTitle = UILabel()
    var thurTitle = UILabel()
    var friTitle = UILabel()
    var satTitle = UILabel()
    var sunTitle = UILabel()
    var totalTitle = UILabel()
    
    private let myTextView1: UITextView = { // header text view
        let textView1 = UITextView()
        textView1.font = .systemFont(ofSize: 26)
        textView1.textColor = .nonBasic
        textView1.textAlignment = .center
        textView1.text = "\n\nWeek Total"
        textView1.isEditable = false
        return textView1
    }()
    
    init(with text2: String, with text3: String, with text4: String, with text5: String, with text6: String, with text7: String, with text8: String, with text9: String, with text10: String, with rounding: Bool) {
        self.myText2 = text2
        if rounding {
            self.monHours = String(((Double(text3) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.tuesHours = String(((Double(text4) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.wedHours = String(((Double(text5) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.thurHours = String(((Double(text6) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.friHours = String(((Double(text7) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.satHours = String(((Double(text8) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
            self.sunHours = String(((Double(text9) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        }
        else {
            self.monHours = String((Double(text3) ?? 0.0) / 60)
            self.tuesHours = String((Double(text4) ?? 0.0) / 60)
            self.wedHours = String((Double(text5) ?? 0.0) / 60)
            self.thurHours = String((Double(text6) ?? 0.0) / 60)
            self.friHours = String((Double(text7) ?? 0.0) / 60)
            self.satHours = String((Double(text8) ?? 0.0) / 60)
            self.sunHours = String((Double(text9) ?? 0.0) / 60)
        }
        self.totalHours = text10
        line1 = jf.createLine(color: .nonBasic!)
        line2 = jf.createLine(color: .nonBasic!)
        line3 = jf.createLine(color: .nonBasic!)
        line4 = jf.createLine(color: .nonBasic!)
        backgroundColor = jf.createLine(color: (.customPurple2?.withAlphaComponent(0.65))!)
        
        textView2 = jf.createLabel(fontSize: 18, text: self.myText2, color: .nonBasic!, align: .center)
        monLabel = jf.createLabel(fontSize: 22, text: self.monHours, color: .nonBasic!, align: .center)
        tuesLabel = jf.createLabel(fontSize: 22, text: self.tuesHours, color: .nonBasic!, align: .center)
        wedLabel = jf.createLabel(fontSize: 22, text: self.wedHours, color: .nonBasic!, align: .center)
        thurLabel = jf.createLabel(fontSize: 22, text: self.thurHours, color: .nonBasic!, align: .center)
        friLabel = jf.createLabel(fontSize: 22, text: self.friHours, color: .nonBasic!, align: .center)
        satLabel = jf.createLabel(fontSize: 22, text: self.satHours, color: .nonBasic!, align: .center)
        sunLabel = jf.createLabel(fontSize: 22, text: self.sunHours, color: .nonBasic!, align: .center)
        totalLabel = jf.createLabel(fontSize: 22, text: self.totalHours, color: .nonBasic!, align: .center)
        
        monTitle = jf.createLabel(fontSize: 22, text: "Monday", color: .nonBasic!)
        tuesTitle = jf.createLabel(fontSize: 22, text: "Tuesday", color: .nonBasic!)
        wedTitle = jf.createLabel(fontSize: 22, text: "Wednesday", color: .nonBasic!)
        thurTitle = jf.createLabel(fontSize: 22, text: "Thursday", color: .nonBasic!)
        friTitle = jf.createLabel(fontSize: 22, text: "Friday", color: .nonBasic!)
        satTitle = jf.createLabel(fontSize: 22, text: "Saturday", color: .nonBasic!)
        sunTitle = jf.createLabel(fontSize: 22, text: "Sunday", color: .nonBasic!)
        totalTitle = jf.createLabel(fontSize: 22, text: "Total Earned\t\t:\t$", color: .nonBasic!)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.myTextView1)
        view.addSubview(self.textView2)
        /* mon-sun labels */
        view.addSubview(self.monTitle)
        view.addSubview(self.tuesTitle)
        view.addSubview(self.wedTitle)
        view.addSubview(self.thurTitle)
        view.addSubview(self.friTitle)
        view.addSubview(self.satTitle)
        view.addSubview(self.sunTitle)
        view.addSubview(self.totalTitle)
        /* hours input */
        view.addSubview(self.monLabel)
        view.addSubview(self.tuesLabel)
        view.addSubview(self.wedLabel)
        view.addSubview(self.thurLabel)
        view.addSubview(self.friLabel)
        view.addSubview(self.satLabel)
        view.addSubview(self.sunLabel)
        view.addSubview(self.totalLabel)
        /* separation lines */
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(line3)
        view.addSubview(line4)
        view.addSubview(backgroundColor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        myTextView1.frame = view.bounds
        textView2.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 40)
        /* mon-sun */
        monTitle.frame = CGRect(x: 60, y: 170, width: 150, height: 50)
        tuesTitle.frame = CGRect(x: 60, y: 230, width: 150, height: 50)
        wedTitle.frame = CGRect(x: 60, y: 290, width: 150, height: 50)
        thurTitle.frame = CGRect(x: 60, y: 350, width: 150, height: 50)
        friTitle.frame = CGRect(x: 60, y: 410, width: 150, height: 50)
        satTitle.frame = CGRect(x: 60, y: 470, width: 150, height: 50)
        sunTitle.frame = CGRect(x: 60, y: 530, width: 150, height: 50)
        totalTitle.frame = CGRect(x: 60, y: 600, width: 210, height: 50)
        /* hours */
        monLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 170, width: 70, height: 50)
        tuesLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 230, width: 70, height: 50)
        wedLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 290, width: 70, height: 50)
        thurLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 350, width: 70, height: 50)
        friLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 410, width: 70, height: 50)
        satLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 470, width: 70, height: 50)
        sunLabel.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 530, width: 70, height: 50)
        totalLabel.frame = CGRect(x: view.bounds.width - CGFloat(110), y: 600, width: 70, height: 50)
        /* separation lines */
        line1.frame = CGRect(x: 40, y: 600, width: view.bounds.width - CGFloat(80), height: 1)
        line2.frame = CGRect(x: 40, y: 650, width: view.bounds.width - CGFloat(80), height: 1)
        line3.frame = CGRect(x: 40, y: 160, width: view.bounds.width - CGFloat(80), height: 1)
        line4.frame = CGRect(x: 230, y: 160, width: 1, height: 440)
        backgroundColor.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
}
