//
//  DetailsViewController.swift
//  Hourly
//
//  Created by Anastasia Grosch on 3/20/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var info = ""
    var heading = ""
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = heading
        label.numberOfLines = 0
        label.text = info
        label.sizeToFit()
    }
    

}
