//
//  HelpCenterTableViewController.swift
//  Hourly
//
//  Page for links to different help center questions
//
//  Created by Anastasia Grosch on 3/19/22.
//

import UIKit

struct HelpInfo {
    var name: String
    var info: String
}

class HelpCenterTableViewController: UITableViewController, UISearchBarDelegate {
    
    let sections = ["Troubleshooting", "General FAQ's"]
    let dataText = [[HelpInfo(name: "How do I remove a job?", info: "To remove a button, press and hold the button until a pop up comes on your screen. Then select either \"Delete\" or \"Cancel\"."),
                     HelpInfo(name: "How do I edit a job's information?", info: "You cannot edit an already existing job button's information. If you need to change the information, you must delete the option with an error and create a new option."),
                     HelpInfo(name: "Why are my reported hours 0?", info: "The Total Hours page resets your hours to zero every week on Sunday at midnight. You can also reset your week's hours manually with the \"Reset Hours\" button located at the top left of the home screen.")],
                    /* General FAQ's section */
                    [HelpInfo(name: "How many jobs can I put?", info: "You can save a maximum of five jobs."),
                     HelpInfo(name: "Can I clear my hours manually?", info: "You can manually clear all of your hours from the week with the arrow icon button located next to the settings button at the top of the home screen. However, you cannot reset the recorded hours for a single day or for a single job."),
                    HelpInfo(name: "Control hour rounding", info: "To have the recorded hours rounded to the nearest hour, set the Enable Rounding switch in Settings to ON."),
                     HelpInfo(name: "Resetting App", info: "Pressing the DELETE ALL JOBS button in Settings will: \n\n(1) Delete each job's saved information.\n\n(2) Remove each job button on the home page.\n\n(3) Delete all recorded hours.\n\n(4) Enable Rounding will return to its ON position.")]
    ]
    
    var filteredData: [[HelpInfo]] = [[]]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemTeal]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        searchBar.delegate = self
        filteredData = dataText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        for i in 0..<sections.count {
            filteredData[i] = searchText.isEmpty ? dataText[i] : dataText[i].filter { (item: HelpInfo) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        }
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .lightGray
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.filteredData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell", for: indexPath)
        let data = filteredData[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = data.name
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        let data = filteredData[indexPath.section][indexPath.row]
        vc.heading = data.name
        vc.info = data.info
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var tmp = String()
        if filteredData[section].isEmpty == false {
            tmp = self.sections[section]
        }
        return tmp
    }
    
}

