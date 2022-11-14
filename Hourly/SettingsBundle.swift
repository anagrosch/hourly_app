//
//  SettingsBundle.swift
//  Hourly
//
//  Created by Anastasia Grosch on 11/13/22.
//

import Foundation
class SettingsBundleHelper {
    
    class func registerSettingsBundle(){
       let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }

    class func updateDisplayFromDefaults(){   // Get the defaults
        var jobName = ["", "", "", "", ""]
        var wages = [0.0, 0.0, 0.0, 0.0, 0.0]
        
        let defaults = UserDefaults.standard
        let rounding = defaults.bool(forKey: "enable_rounding_prefernce")
        if let job1 = defaults.string(forKey: "job1_preference") {
            jobName[0] = job1
        } else { jobName[0] = "" }
        if let wage1 = defaults.string(forKey: "wage1_preference") {
            wages[0] = Double(wage1) ?? 0.0
        }
        ViewController().modify(array: &jobName)
        ViewController().modifyPay(array: &wages)
    }
    
    struct SettingsBundleKeys {
        static let Rounding = "enable_rounding_preference"
        static let Job1 = "job1_preference"
        static let Wage1 = "wage1_preference"
        static let Job2 = "job2_preference"
        static let Wage2 = "wage2_preference"
        static let Job3 = "job3_preference"
        static let Wage3 = "wage3_preference"
        static let Job4 = "job4_preference"
        static let Wage4 = "wage4_preference"
        static let Job5 = "job5_preference"
        static let Wage5 = "wage5_preference"
        static let DeleteAll = "delete_all_preference"
    }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.DeleteAll) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.DeleteAll)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        }
    }
    
}
