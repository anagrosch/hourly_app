//
//  DetailsViewController.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/20/22.
//

import UIKit

class DetailsViewController: UIViewController {

    let jf = JobFunctions()
    let screen = UIScreen.main.bounds
    var navH: CGFloat = 0
    var info = ""
    var heading = ""
    var line = UIView()
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = heading
        view.backgroundColor = .basic
        
        navH = (self.navigationController?.navigationBar.frame.height)!
        
        line = jf.createLine()
        label = jf.createLabel(text: info, color: .nonBasic!)
        view.addSubview(line)
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        line.frame = CGRect(x: 0, y: 2.2*navH, width: screen.width, height: 2)
        label.frame = CGRect(x: 30, y: 2*(screen.height/13), width: screen.width - 60, height: 75)
    }
    
}
