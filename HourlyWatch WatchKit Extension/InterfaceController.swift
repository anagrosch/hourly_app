//
//  InterfaceController.swift
//  HourlyWatch WatchKit Extension
//
//  Created by Anastasia Grosch on 11/30/22.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var startButton: WKInterfaceButton!
    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    
    var timerCounting: Bool = false //true = on, false = off
    var timer: Timer = Timer()
    var count: Int = 0
    var timeString: String = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Timer")
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func stopwatchButton() {
        if timerCounting {
            let action1 = WKAlertAction(title: "Pause", style: .default) {
                self.timerCounting = false
                self.startButton.setTitle("RESUME")
            }
            let action2 = WKAlertAction(title: "Stop", style: .default) {
                self.timerLabel.setHidden(true)
                self.startButton.setHidden(true)
                self.label.setHeight(300)
                self.label.setText("You're Done!\nFinal Time: " + self.timeString.prefix(5) + "\n\nSave time on\nnext page >>")
                
            }
            
            self.timer.invalidate()
            presentAlert(withTitle: "Actions", message: "Select \"Stop\" to end session.", preferredStyle: .actionSheet, actions: [action1, action2])
        }
        else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true )
            startButton.setTitle("STOP")
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutes(seconds: count)
        timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.setText(timeString)
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
    
}
