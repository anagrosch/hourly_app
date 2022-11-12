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

    let myText2: String
    let myText3: String
    let myText4: String
    let myText5: String
    let myText6: String
    let myText7: String
    let myText8: String
    let myText9: String
    let myText10: String
    
    private let myTextView1: UITextView = { // header text view
        let textView1 = UITextView()
        textView1.font = .systemFont(ofSize: 26)
        textView1.textColor = .white
        textView1.textAlignment = .center
        textView1.text = "\n\nWeek Total"
        textView1.isEditable = false
        return textView1
    }()
    
    private let myTextView2: UILabel = { // job position label
        let textView2 = UILabel()
        textView2.font = .systemFont(ofSize: 18)
        textView2.textColor = .white
        textView2.textAlignment = .center
        return textView2
    }()
    
    /* mon-sun labels*/
    private let myTextView3A: UILabel = {
        let textView3A = UILabel()
        textView3A.font = .systemFont(ofSize: 22)
        textView3A.textColor = .white
        textView3A.text = "Monday"
        return textView3A
    }()
    
    private let myTextView4A: UILabel = {
        let textView4A = UILabel()
        textView4A.font = .systemFont(ofSize: 22)
        textView4A.textColor = .white
        textView4A.text = "Tuesday"
        return textView4A
    }()
    
    private let myTextView5A: UILabel = {
        let textView5A = UILabel()
        textView5A.font = .systemFont(ofSize: 22)
        textView5A.textColor = .white
        textView5A.text = "Wednesday"
        return textView5A
    }()
    
    private let myTextView6A: UILabel = {
        let textView6A = UILabel()
        textView6A.font = .systemFont(ofSize: 22)
        textView6A.textColor = .white
        textView6A.text = "Thursday"
        return textView6A
    }()
    
    private let myTextView7A: UILabel = {
        let textView7A = UILabel()
        textView7A.font = .systemFont(ofSize: 22)
        textView7A.textColor = .white
        textView7A.text = "Friday"
        return textView7A
    }()
    
    private let myTextView8A: UILabel = {
        let textView8A = UILabel()
        textView8A.font = .systemFont(ofSize: 22)
        textView8A.textColor = .white
        textView8A.text = "Saturday"
        return textView8A
    }()
    
    private let myTextView9A: UILabel = {
        let textView9A = UILabel()
        textView9A.font = .systemFont(ofSize: 22)
        textView9A.textColor = .white
        textView9A.text = "Sunday"
        return textView9A
    }()
    /* total label */
    private let myTextView10A: UILabel = {
        let textView10A = UILabel()
        textView10A.font = .systemFont(ofSize: 22)
        textView10A.textColor = .white
        textView10A.text = "Total Earned\t\t:\t$"
        return textView10A
    }()
    
    /* hours labels */
    private let myTextView3: UILabel = {
        let textView3 = UILabel()
        textView3.font = .systemFont(ofSize: 22)
        textView3.textColor = .white
        textView3.textAlignment = .center
        return textView3
    }()
    
    private let myTextView4: UILabel = {
        let textView4 = UILabel()
        textView4.font = .systemFont(ofSize: 22)
        textView4.textColor = .white
        textView4.textAlignment = .center
        return textView4
    }()
    
    private let myTextView5: UILabel = {
        let textView5 = UILabel()
        textView5.font = .systemFont(ofSize: 22)
        textView5.textColor = .white
        textView5.textAlignment = .center
        return textView5
    }()
    
    private let myTextView6: UILabel = {
        let textView6 = UILabel()
        textView6.font = .systemFont(ofSize: 22)
        textView6.textColor = .white
        textView6.textAlignment = .center
        return textView6
    }()
    
    private let myTextView7: UILabel = {
        let textView7 = UILabel()
        textView7.font = .systemFont(ofSize: 22)
        textView7.textColor = .white
        textView7.textAlignment = .center
        return textView7
    }()
    
    private let myTextView8: UILabel = {
        let textView8 = UILabel()
        textView8.font = .systemFont(ofSize: 22)
        textView8.textColor = .white
        textView8.textAlignment = .center
        return textView8
    }()
    
    private let myTextView9: UILabel = {
        let textView9 = UILabel()
        textView9.font = .systemFont(ofSize: 22)
        textView9.textColor = .white
        textView9.textAlignment = .center
        return textView9
    }()
    
    private let myTextView10: UILabel = {
        let textView10 = UILabel()
        textView10.font = .systemFont(ofSize: 22)
        textView10.textColor = .white
        textView10.textAlignment = .center
        return textView10
    }()
    
    /* separation lines */
    private let myTotalLine: UIView = {
        let totalLine = UIView()
        totalLine.backgroundColor = .white
        return totalLine
    }()
    
    private let myTotalLine2: UIView = {
        let totalLine2 = UIView()
        totalLine2.backgroundColor = .white
        return totalLine2
    }()
    
    private let myTotalLine3: UIView = {
        let totalLine3 = UIView()
        totalLine3.backgroundColor = .white
        return totalLine3
    }()
    
    private let myHorizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = .white
        return horizontalLine
    }()
    
    private let myBackgroundColor: UIView = {
        let backgroundColor = UIView()
        backgroundColor.backgroundColor = .systemIndigo.withAlphaComponent(0.65)//UIColor(red: 0.8, green: 1.0, blue: 0.7, alpha: 0.7)
        return backgroundColor
    }()
    
    
    init(with text2: String, with text3: String, with text4: String, with text5: String, with text6: String, with text7: String, with text8: String, with text9: String, with text10: String) {
        self.myText2 = text2
        self.myText3 = String(((Double(text3) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText4 = String(((Double(text4) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText5 = String(((Double(text5) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText6 = String(((Double(text6) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText7 = String(((Double(text7) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText8 = String(((Double(text8) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText9 = String(((Double(text9) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero))
        self.myText10 = text10
        myTextView2.text = self.myText2
        myTextView3.text = self.myText3
        myTextView4.text = self.myText4
        myTextView5.text = self.myText5
        myTextView6.text = self.myText6
        myTextView7.text = self.myText7
        myTextView8.text = self.myText8
        myTextView9.text = self.myText9
        myTextView10.text = self.myText10
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        
        view.addSubview(self.myTextView1)
        view.addSubview(self.myTextView2)
        /* mon-sun labels */
        view.addSubview(self.myTextView3A)
        view.addSubview(self.myTextView4A)
        view.addSubview(self.myTextView5A)
        view.addSubview(self.myTextView6A)
        view.addSubview(self.myTextView7A)
        view.addSubview(self.myTextView8A)
        view.addSubview(self.myTextView9A)
        view.addSubview(self.myTextView10A)
        /* hours input */
        view.addSubview(self.myTextView3)
        view.addSubview(self.myTextView4)
        view.addSubview(self.myTextView5)
        view.addSubview(self.myTextView6)
        view.addSubview(self.myTextView7)
        view.addSubview(self.myTextView8)
        view.addSubview(self.myTextView9)
        view.addSubview(self.myTextView10)
        /* separation lines */
        view.addSubview(myTotalLine)
        view.addSubview(myTotalLine2)
        view.addSubview(myTotalLine3)
        view.addSubview(myHorizontalLine)
        view.addSubview(myBackgroundColor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        myTextView1.frame = view.bounds
        myTextView2.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 40)
        myTextView2.textAlignment = .center
        /* mon-sun */
        myTextView3A.frame = CGRect(x: 60, y: 170, width: 150, height: 50)
        myTextView4A.frame = CGRect(x: 60, y: 230, width: 150, height: 50)
        myTextView5A.frame = CGRect(x: 60, y: 290, width: 150, height: 50)
        myTextView6A.frame = CGRect(x: 60, y: 350, width: 150, height: 50)
        myTextView7A.frame = CGRect(x: 60, y: 410, width: 150, height: 50)
        myTextView8A.frame = CGRect(x: 60, y: 470, width: 150, height: 50)
        myTextView9A.frame = CGRect(x: 60, y: 530, width: 150, height: 50)
        myTextView10A.frame = CGRect(x: 60, y: 600, width: 210, height: 50)
        /* hours */
        myTextView3.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 170, width: 70, height: 50)
        myTextView4.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 230, width: 70, height: 50)
        myTextView5.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 290, width: 70, height: 50)
        myTextView6.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 350, width: 70, height: 50)
        myTextView7.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 410, width: 70, height: 50)
        myTextView8.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 470, width: 70, height: 50)
        myTextView9.frame = CGRect(x: view.bounds.width - CGFloat(120), y: 530, width: 70, height: 50)
        myTextView10.frame = CGRect(x: view.bounds.width - CGFloat(110), y: 600, width: 70, height: 50)
        /* separation lines */
        myTotalLine.frame = CGRect(x: 40, y: 600, width: view.bounds.width - CGFloat(80), height: 1)
        myTotalLine2.frame = CGRect(x: 40, y: 650, width: view.bounds.width - CGFloat(80), height: 1)
        myTotalLine3.frame = CGRect(x: 40, y: 160, width: view.bounds.width - CGFloat(80), height: 1)
        myHorizontalLine.frame = CGRect(x: 230, y: 160, width: 1, height: 440)
        myBackgroundColor.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
}
