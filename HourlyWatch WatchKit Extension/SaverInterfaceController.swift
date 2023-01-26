//
//  SaverInterfaceController.swift
//  HourlyWatch WatchKit Extension
//
//  Created by Anastasia Grosch on 12/12/22.
//

import WatchKit
import Foundation
import CoreData

class SaverInterfaceController: WKInterfaceController {
    
    /* Core Data initialization */
    //let context = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    //private var jobPositionModels = [JobPositions]()
    
    @IBOutlet weak var jobPicker: WKInterfacePicker!
    @IBOutlet weak var label: WKInterfaceLabel!

    var jobList: [(String, String)] = [
        ("Item 1", "Job 1"),
        ("Item 2", "Job 2"),
        ("Item 3", "Job 3"),
        ("Item 4", "Job 4"),
        ("Item 5", "Job 5")
    ]
    
    var tmpString = ["","","","",""]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //saveHours()
        
        let pickerItems: [WKPickerItem] = jobList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = $0.0
            pickerItem.title = $0.1
            return pickerItem
        }
        jobPicker.setItems(pickerItems)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func jobPicked(_ value: Int) {
    }
    
    @IBAction func saveButtonHit() {
        label.setText(tmpString[0])
    }
    /*
    func getJobName(array: inout [String]) {
        do {
            jobPositionModels = try context.fetch(JobPositions.fetchRequest())
            for info in jobPositionModels {
                array[0] = info.job1name!
                array[1] = info.job2name!
                array[2] = info.job3name!
                array[3] = info.job4name!
                array[4] = info.job5name!
            }
        }
        catch {
            //error
        }
    }
    
    func saveHours() {
        let item = JobPositions(context: context)
        item.job1name = "test"
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }*/
    
}
