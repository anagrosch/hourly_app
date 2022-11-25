//
//  TimerViewController.swift
//  Hourly
//
//  Page for timing each job's hours
//
//  Created by Anastasia Grosch on 3/17/22.
//

import UIKit

class TimerViewController: UIViewController {

    let jobFunc = JobFunctions()
    
    var timer: Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    var jobNumber = 0
    var pay = [0.0, 0.0, 0.0, 0.0, 0.0]
    var jobName = ["", "", "", "", ""]
    var hoursWorked: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var final = Int16()
    
    @IBOutlet weak var displayStopwatch: UILabel!
    @IBOutlet weak var displayInfo: UILabel!
    @IBOutlet weak var displayFinalTime: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        jobFunc.modify(array: &jobName)
        jobFunc.modifyPay(array: &pay)
        
        displayFinalTime.isHidden = true
        displayInfo.layer.borderWidth = 2.5
        displayInfo.layer.borderColor = UIColor.systemTeal.cgColor
        displayInfo.text = "\tJob: " + jobName[jobNumber - 1] + "\n\n\tWage: $" + String(format: "%.2f", pay[jobNumber - 1]) + "/hr" + "\n\n"
        
    }
    
    func saveHoursToJobInfo(num: Int16) {
        switch jobNumber {
        case 1:
            jobFunc.modify1Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jobFunc.save1HoursFromTmp(array: &hoursWorked)
        case 2:
            jobFunc.modify2Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jobFunc.save2HoursFromTmp(array: &hoursWorked)
        case 3:
            jobFunc.modify3Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jobFunc.save3HoursFromTmp(array: &hoursWorked)
        case 4:
            jobFunc.modify4Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jobFunc.save4HoursFromTmp(array: &hoursWorked)
        case 5:
            jobFunc.modify5Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jobFunc.save5HoursFromTmp(array: &hoursWorked)
        default:
            displayFinalTime.text = "Error"
        }
    }
    
    @IBAction func startStopWatch(_ sender: Any) {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            startButton.setTitle("RESUME", for: .normal)
        }
        else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true )
            startButton.setTitle("PAUSE", for: .normal)
        }
    }
    
    @IBAction func stopStopWatch(_ sender: Any) {
        timer.invalidate()
        let alert = UIAlertController(title: "Stop Timer?", message: "If yes, exit session before restarting timer or progress will be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true )
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.saveHoursToJobInfo(num: self.final)
            
            self.displayFinalTime.isHidden = false
            self.count = 0
            self.timer.invalidate()
            self.displayStopwatch.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            
            self.startButton.setTitle("START", for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutes(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        displayStopwatch.text = timeString
        displayFinalTime.text = "Final Time = " + timeString
        final = Int16(setTotalTime(hrs: time.0, min: time.1))
    }
    
    func secondsToHoursMinutes(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func setTotalTime(hrs: Int, min: Int) -> Int {
        return (hrs * 60) + (min)
    }
    
    /* button to go back to home screen */
    @IBAction func exitScreen(_ sender: Any) {
        dismiss(animated: true, completion:  nil)
    }
    
}

extension Date { // 1=sunday, 7=saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
