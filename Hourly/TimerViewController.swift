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

    let jf = JobFunctions()
    
    var timer: Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    var jobNumber = 0
    var pay = [0.0, 0.0, 0.0, 0.0, 0.0]
    var jobName = ["", "", "", "", ""]
    var hoursWorked: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var final = Int16()
    
    var heading = UILabel()
    var displayInfo = UILabel()
    let displayFinalTime = UILabel()
    var displayStopwatch = UILabel()
    var startButton = UIButton()
    var endButton = UIButton()
    var sessionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customTeal

        jf.modify(array: &jobName)
        jf.modifyPay(array: &pay)
        
        heading = jf.createHeading(text: "GOOD LUCK!", color: .white)
        displayInfo = jf.createLabel(text: "\tJob: " + jobName[jobNumber - 1] + "\n\n\tWage: $" + String(format: "%.2f", pay[jobNumber - 1]) + "/hr" + "\n\n", color: .white)
        displayInfo.layer.borderWidth = 2.5
        displayInfo.layer.borderColor = UIColor.tealButton?.cgColor
        displayFinalTime.textColor = .white
        displayFinalTime.isHidden = true
        displayStopwatch = jf.createLabel(fontSize: 60, text: "00:00:00", color: .white, align: .center)
        startButton = jf.createButton(fontSize: 50, textColor: .white, buttonColor: .tealButton!, corner: 5, text: "START")
        endButton = jf.createButton(fontSize: 50, textColor: .white, buttonColor: .tealButton!, corner: 5, text: "END")
        sessionButton = jf.createButton(fontSize: 40, textColor: .white, buttonColor: .tealButton!, corner: 5, text: "END SESSION")
        
        view.addSubview(heading)
        view.addSubview(displayInfo)
        view.addSubview(displayFinalTime)
        view.addSubview(displayStopwatch)
        view.addSubview(startButton)
        view.addSubview(endButton)
        view.addSubview(sessionButton)

        startButton.addTarget(self, action: #selector(startStopWatch(_:)), for: .touchUpInside)
        endButton.addTarget(self, action: #selector(stopStopWatch(_:)), for: .touchUpInside)
        sessionButton.addTarget(self, action: #selector(exitScreen(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        heading.frame = CGRect(x: 30, y: 75, width: 315, height: 50)
        displayInfo.frame = CGRect(x: 35, y: 155, width: 305, height: 140)
        displayFinalTime.frame = CGRect(x: 62, y: 250, width: 300, height: 33)
        displayStopwatch.frame = CGRect(x: 35, y: 444, width: 305, height: 122)
        startButton.frame = CGRect(x: 23, y: 364, width: 156, height: 40)
        endButton.frame = CGRect(x: 196, y: 364, width: 156, height: 40)
        sessionButton.frame = CGRect(x: 23, y: 616, width: 329, height: 40)
    }
    
    func saveHoursToJobInfo(num: Int16) {
        switch jobNumber {
        case 1:
            jf.modify1Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jf.save1HoursFromTmp(array: &hoursWorked)
        case 2:
            jf.modify2Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jf.save2HoursFromTmp(array: &hoursWorked)
        case 3:
            jf.modify3Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jf.save3HoursFromTmp(array: &hoursWorked)
        case 4:
            jf.modify4Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jf.save4HoursFromTmp(array: &hoursWorked)
        case 5:
            jf.modify5Hours(array: &hoursWorked)
            hoursWorked[Date().dayNumberOfWeek()! - 1] += num
            jf.save5HoursFromTmp(array: &hoursWorked)
        default:
            displayFinalTime.text = "Error"
        }
    }
    
    @objc func startStopWatch(_ sender: Any) {
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
    
    @objc func stopStopWatch(_ sender: Any) {
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
    @objc func exitScreen(_ sender: Any) {
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
