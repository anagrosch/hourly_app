//
//  JobFunctions.swift
//  Hourly
//
//  Created by Anastasia Grosch on 11/24/22.
//

import UIKit
import WatchConnectivity

class JobFunctions: NSObject {
    
    /* Core Data initializations */
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var roundingModels = [RoundingOption]()
    private var hideButtonModels = [HideButtons]()
    private var jobPositionsModels = [JobPositions]()
    
    private var jobPayModels = [JobWages]()
    private var job1Models = [Job1Info]()
    private var job2Models = [Job2Info]()
    private var job3Models = [Job3Info]()
    private var job4Models = [Job4Info]()
    private var job5Models = [Job5Info]()
    
    var tmpString = ["", "", "", "", ""]
    var tmpDouble = [0.0, 0.0, 0.0, 0.0, 0.0]
    var tmpBool = [true, true, true, true, true]
    
    var tmp1Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp2Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp3Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp4Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp5Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var clearAll: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    
    var pdfTitle: String = "<center><p><h2>My Work Week Summary</h2></br><hr></br></center>"
    var pdfJobLine: String = "</b><span style=\"margin-left:10em\"><b>Job "
    var pdfWageLine: String = "</b><span style=\"margin-left:10em\">Wage: "
    var pdfData: String = ""
   
    func clearHours(array: inout [Int16]) {
        for i in 0...6 {
            array[i] = 0
        }
    }
    
    /* Visuals */
    func createBorder() -> UIView {
        let box = UIView()
        box.backgroundColor = .border
        box.layer.cornerRadius = 10
        return box
    }
    
    func createBarButton(image: UIImage?, target: Any?, action: Selector) -> UIBarButtonItem {
        let bar = UIButton()
        bar.setImage(image, for: .normal)
        bar.addTarget(target, action: action, for: .touchUpInside)
        bar.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return UIBarButtonItem(customView: bar)
    }
    
    func createButton(fontSize: CGFloat = 16, textColor: UIColor, buttonColor: UIColor, corner: CGFloat, text: String = "") -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "System", size: fontSize)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = corner
        button.setTitle(text, for: .normal)
        return button
    }
    
    func createHeading(text: String, color: UIColor) -> UILabel {
        let heading = UILabel()
        heading.font = .preferredFont(forTextStyle: .title1)
        heading.textColor = color
        heading.textAlignment = .center
        heading.text = text
        return heading
    }
    
    func createLabel(fontSize: CGFloat = 16, text: String, color: UIColor, align: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = align
        label.text = text
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
    
    func createLine(color: UIColor = .customTeal!) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        return line
    }
    
    func createTextField(alpha: CGFloat = 1, color: UIColor, corner: CGFloat, textColor: UIColor = .nonBasic!, align: NSTextAlignment, indent: CGFloat = 0, tmpText: String = "", text: String = "") -> UITextField {
        let field = UITextField()
        field.alpha = alpha
        field.backgroundColor = color
        field.layer.cornerRadius = corner
        field.font = .systemFont(ofSize: 16)
        field.textColor = textColor
        field.textAlignment = align
        field.setPadding(left: indent)
        field.placeholder = tmpText
        field.text = text
        return field
    }
    
    /* TimerViewController functions */
    @objc func clearHours() {
        save1HoursFromTmp(array: &clearAll)
        save2HoursFromTmp(array: &clearAll)
        save3HoursFromTmp(array: &clearAll)
        save4HoursFromTmp(array: &clearAll)
        save5HoursFromTmp(array: &clearAll)
    }
    
    /* PDF functions */
    func createUnroundedPDFString() -> String {
        modifyPay(array: &tmpDouble)
        modify(array: &tmpString)
        modifyBool(array: &tmpBool)
        
        if !(tmpBool[0]) {
            pdfData = pdfTitle
            modify1Hours(array: &tmp1Hours)
            
            pdfData += "<table><tr><td>" + pdfJobLine + "1: " + tmpString[0] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[0]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String(Double(tmp1Hours[1]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String(Double(tmp1Hours[2]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String(Double(tmp1Hours[3]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String(Double(tmp1Hours[4]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String(Double(tmp1Hours[5]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String(Double(tmp1Hours[6]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String(Double(tmp1Hours[0]) / 60) + "</br>"
            pdfData += "</td>"
        }
        if !(tmpBool[1]) {
            modify2Hours(array: &tmp2Hours)
            
            pdfData += "<td>" + pdfJobLine + "2: " + tmpString[1] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[1]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String(Double(tmp2Hours[1]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String(Double(tmp2Hours[2]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String(Double(tmp2Hours[3]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String(Double(tmp2Hours[4]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String(Double(tmp2Hours[5]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String(Double(tmp2Hours[6]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String(Double(tmp2Hours[0]) / 60) + "</br>"
            pdfData += "</td></tr></table>"
        }
        if !(tmpBool[2]) {
            modify3Hours(array: &tmp3Hours)
            
            pdfData += "<hr></br><table><tr><td>" + pdfJobLine + "3: " + tmpString[2] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[2]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String(Double(tmp3Hours[1]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String(Double(tmp3Hours[2]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String(Double(tmp3Hours[3]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String(Double(tmp3Hours[4]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String(Double(tmp3Hours[5]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String(Double(tmp3Hours[6]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String(Double(tmp3Hours[0]) / 60) + "</br>"
            pdfData += "</td>"
        }
        if !(tmpBool[3]) {
            modify4Hours(array: &tmp4Hours)
            
            pdfData += "<td>" + pdfJobLine + "4: " + tmpString[3] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[3]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String(Double(tmp4Hours[1]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String(Double(tmp4Hours[2]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String(Double(tmp4Hours[3]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String(Double(tmp4Hours[4]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String(Double(tmp4Hours[5]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String(Double(tmp4Hours[6]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String(Double(tmp4Hours[0]) / 60) + "</br>"
            pdfData += "</td></tr></table>"
        }
        if !(tmpBool[4]) {
            modify5Hours(array: &tmp5Hours)
            
            pdfData += "<hr></br><table><tr><td>" + pdfJobLine + "5: " + tmpString[4] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[4]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String(Double(tmp5Hours[1]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String(Double(tmp5Hours[2]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String(Double(tmp5Hours[3]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String(Double(tmp5Hours[4]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String(Double(tmp5Hours[5]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String(Double(tmp5Hours[6]) / 60) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String(Double(tmp5Hours[0]) / 60) + "</br>"
            pdfData += "</td></tr></table>"
        }
        return pdfData
    }
    
    func createRoundedPDFString() -> String {
        modifyPay(array: &tmpDouble)
        modify(array: &tmpString)
        modifyBool(array: &tmpBool)
        
        if !(tmpBool[0]) {
            pdfData = pdfTitle
            modify1Hours(array: &tmp1Hours)
            
            pdfData += "<table><tr><td>" + pdfJobLine + "1: " + tmpString[0] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[0]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String((Double(tmp1Hours[1]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String((Double(tmp1Hours[2]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String((Double(tmp1Hours[3]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String((Double(tmp1Hours[4]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String((Double(tmp1Hours[5]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String((Double(tmp1Hours[6]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String((Double(tmp1Hours[0]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "</td>"
        }
        if !(tmpBool[1]) {
            modify2Hours(array: &tmp2Hours)
            
            pdfData += "<td>" + pdfJobLine + "2: " + tmpString[1] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[1]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String((Double(tmp2Hours[1]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String((Double(tmp2Hours[2]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String((Double(tmp2Hours[3]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String((Double(tmp2Hours[4]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String((Double(tmp2Hours[5]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String((Double(tmp2Hours[6]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String((Double(tmp2Hours[0]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "</td></tr></table>"
        }
        if !(tmpBool[2]) {
            modify3Hours(array: &tmp3Hours)
            
            pdfData += "<hr></br><table><tr><td>" + pdfJobLine + "3: " + tmpString[2] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[2]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String((Double(tmp3Hours[1]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String((Double(tmp3Hours[2]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String((Double(tmp3Hours[3]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String((Double(tmp3Hours[4]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String((Double(tmp3Hours[5]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String((Double(tmp3Hours[6]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String((Double(tmp3Hours[0]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "</td>"
        }
        if !(tmpBool[3]) {
            modify4Hours(array: &tmp4Hours)
            
            pdfData += "<td>" + pdfJobLine + "4: " + tmpString[3] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[3]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String((Double(tmp4Hours[1]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String((Double(tmp4Hours[2]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String((Double(tmp4Hours[3]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String((Double(tmp4Hours[4]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String((Double(tmp4Hours[5]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String((Double(tmp4Hours[6]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String((Double(tmp4Hours[0]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "</td></tr></table>"
        }
        if !(tmpBool[4]) {
            modify5Hours(array: &tmp5Hours)
            
            pdfData += "<hr></br><table><tr><td>" + pdfJobLine + "5: " + tmpString[4] + "</br>"
            pdfData += pdfWageLine + String(tmpDouble[4]) + "</b></br>"
            pdfData += "<span style=\"margin-left:10em\">---------------------</br>"
            pdfData += "<p><span style=\"margin-left:10em\">Monday: " + String((Double(tmp5Hours[1]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Tuesday: " + String((Double(tmp5Hours[2]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Wednesday: " + String((Double(tmp5Hours[3]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Thursday: " + String((Double(tmp5Hours[4]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Friday: " + String((Double(tmp5Hours[5]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Saturday: " + String((Double(tmp5Hours[6]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "<span style=\"margin-left:10em\">Sunday: " + String((Double(tmp5Hours[0]) / 60).rounded(.toNearestOrAwayFromZero)) + "</br>"
            pdfData += "</td></tr></table>"
        }
        return pdfData
    }
    
    /* Core Data Functions */
    
    /* get info from Core Data functions */
    func getRounding(Bool: inout Bool) { // get if hours rounding enabled
        do {
            roundingModels = try context.fetch(RoundingOption.fetchRequest())
            for info in roundingModels {
                Bool = info.rounding
            }
        }
        catch {
            //error
        }
    }
    
    func modifyBool(array: inout [Bool]) { // get if buttons are hidden
        do {
            hideButtonModels = try context.fetch(HideButtons.fetchRequest())
            for info in hideButtonModels {
                array[0] = info.button1
                array[1] = info.button2
                array[2] = info.button3
                array[3] = info.button4
                array[4] = info.button5
            }
        }
        catch {
            //error
        }
    }
    
    func modify(array: inout [String]) { // get position names
        do {
            jobPositionsModels = try context.fetch(JobPositions.fetchRequest())
            for info in jobPositionsModels {
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
    
    func modifyPay(array: inout [Double]) { // get hourly wages
        do {
            jobPayModels = try context.fetch(JobWages.fetchRequest())
            for info in jobPayModels {
                array[0] = info.pay1
                array[1] = info.pay2
                array[2] = info.pay3
                array[3] = info.pay4
                array[4] = info.pay5
            }
        }
        catch {
            //error
        }
    }
    
    func modify1Hours(array: inout [Int16]) {
        do {
            job1Models = try context.fetch(Job1Info.fetchRequest())
            for info in job1Models {
                array[0] = info.sundayHours
                array[1] = info.mondayHours
                array[2] = info.tuesdayHours
                array[3] = info.wednesdayHours
                array[4] = info.thursdayHours
                array[5] = info.fridayHours
                array[6] = info.saturdayHours
            }
        }
        catch {
            //error
        }
    }
    
    func modify2Hours(array: inout [Int16]) {
        do {
            job2Models = try context.fetch(Job2Info.fetchRequest())
            for info in job2Models {
                array[0] = info.sundayHours
                array[1] = info.mondayHours
                array[2] = info.tuesdayHours
                array[3] = info.wednesdayHours
                array[4] = info.thursdayHours
                array[5] = info.fridayHours
                array[6] = info.saturdayHours
            }
        }
        catch {
            //error
        }
    }
    
    func modify3Hours(array: inout [Int16]) {
        do {
            job3Models = try context.fetch(Job3Info.fetchRequest())
            for info in job3Models {
                array[0] = info.sundayHours
                array[1] = info.mondayHours
                array[2] = info.tuesdayHours
                array[3] = info.wednesdayHours
                array[4] = info.thursdayHours
                array[5] = info.fridayHours
                array[6] = info.saturdayHours
            }
        }
        catch {
            //error
        }
    }
    
    func modify4Hours(array: inout [Int16]) {
        do {
            job4Models = try context.fetch(Job4Info.fetchRequest())
            for info in job4Models {
                array[0] = info.sundayHours
                array[1] = info.mondayHours
                array[2] = info.tuesdayHours
                array[3] = info.wednesdayHours
                array[4] = info.thursdayHours
                array[5] = info.fridayHours
                array[6] = info.saturdayHours
            }
        }
        catch {
            //error
        }
    }
    
    func modify5Hours(array: inout [Int16]) {
        do {
            job5Models = try context.fetch(Job5Info.fetchRequest())
            for info in job5Models {
                array[0] = info.sundayHours
                array[1] = info.mondayHours
                array[2] = info.tuesdayHours
                array[3] = info.wednesdayHours
                array[4] = info.thursdayHours
                array[5] = info.fridayHours
                array[6] = info.saturdayHours
            }
        }
        catch {
            //error
        }
    }
    
    /* save array info to Core Data functions */
    func saveBoolFromTmp(array: inout [Bool]) { // save if buttons are hidden
        let item = HideButtons(context: context)
        
        item.button1 = array[0]
        item.button2 = array[1]
        item.button3 = array[2]
        item.button4 = array[3]
        item.button5 = array[4]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func saveNamesFromTmp(array: inout [String]) { // save position names
        let item = JobPositions(context: context)
        
        item.job1name = array[0]
        item.job2name = array[1]
        item.job3name = array[2]
        item.job4name = array[3]
        item.job5name = array[4]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func savePayFromTmp(array: inout [Double]) { // save hourly pay
        let item = JobWages(context: context)
        
        item.pay1 = array[0]
        item.pay2 = array[1]
        item.pay3 = array[2]
        item.pay4 = array[3]
        item.pay5 = array[4]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func save1HoursFromTmp(array: inout [Int16]) {
        let item = Job1Info(context: context)
        
        item.sundayHours = array[0]
        item.mondayHours = array[1]
        item.tuesdayHours = array[2]
        item.wednesdayHours = array[3]
        item.thursdayHours = array[4]
        item.fridayHours = array[5]
        item.saturdayHours = array[6]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func save2HoursFromTmp(array: inout [Int16]) {
        let item = Job2Info(context: context)
        
        item.sundayHours = array[0]
        item.mondayHours = array[1]
        item.tuesdayHours = array[2]
        item.wednesdayHours = array[3]
        item.thursdayHours = array[4]
        item.fridayHours = array[5]
        item.saturdayHours = array[6]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func save3HoursFromTmp(array: inout [Int16]) {
        let item = Job3Info(context: context)
        
        item.sundayHours = array[0]
        item.mondayHours = array[1]
        item.tuesdayHours = array[2]
        item.wednesdayHours = array[3]
        item.thursdayHours = array[4]
        item.fridayHours = array[5]
        item.saturdayHours = array[6]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func save4HoursFromTmp(array: inout [Int16]) {
        let item = Job4Info(context: context)
        
        item.sundayHours = array[0]
        item.mondayHours = array[1]
        item.tuesdayHours = array[2]
        item.wednesdayHours = array[3]
        item.thursdayHours = array[4]
        item.fridayHours = array[5]
        item.saturdayHours = array[6]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
    func save5HoursFromTmp(array: inout [Int16]) {
        let item = Job5Info(context: context)
        
        item.sundayHours = array[0]
        item.mondayHours = array[1]
        item.tuesdayHours = array[2]
        item.wednesdayHours = array[3]
        item.thursdayHours = array[4]
        item.fridayHours = array[5]
        item.saturdayHours = array[6]
        
        do {
            try context.save()
        }
        catch {
            //error
        }
    }
    
}
