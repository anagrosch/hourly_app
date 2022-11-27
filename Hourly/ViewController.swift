//
//  ViewController.swift
//  Hourly
//
//  Home page
//
//  Created by Anastasia Grosch on 3/14/22.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITextFieldDelegate {

    /* var for totals page */
    var myControllers = [UIViewController]()
    
    /* Core Data initializations */
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var jobPositionsModels = [JobPositions]()
    let saveImage = UIImage(systemName: "tray.and.arrow.down")?.withTintColor(.customTeal!, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
    let resetImage = UIImage(systemName: "arrow.counterclockwise")?.withTintColor(.customTeal!, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
    let settingsImage = UIImage(systemName: "gearshape")?.withTintColor(.customTeal!, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
    let infoImage = UIImage(systemName: "info.circle")?.withTintColor(.customTeal!, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 30, height: 30))
    
    let jf = JobFunctions()
    
    var tmpString = ["", "", "", "", ""]
    var tmpDouble = [0.0, 0.0, 0.0, 0.0, 0.0]
    var tmpBool = [true, true, true, true, true]
    var sendJobNumber = 0
    var rounds = false
    var pdfData: String = ""
    var screen = UIScreen.main.bounds
    
    var heading = UILabel()
    var line1 = UIView()
    var line2 = UIView()
    var line3 = UIView()
    var job1Button = UIButton()
    var job2Button = UIButton()
    var job3Button = UIButton()
    var job4Button = UIButton()
    var job5Button = UIButton()
    var totalHoursButton = UIButton()
    var addJobButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .basic
        
        heading = jf.createHeading(text: "SELECT POSITION", color: .systemTeal)
        line1 = jf.createLine()
        line2 = jf.createLine()
        line3 = jf.createLine()
        job1Button = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5)
        job2Button = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5)
        job3Button = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5)
        job4Button = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5)
        job5Button = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5)
        addJobButton = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5, text: "ADD JOB")
        totalHoursButton = jf.createButton(textColor: .systemTeal, buttonColor: (.blueButton?.withAlphaComponent(0.6))!, corner: 5, text: "TOTAL HOURS")
        
        view.addSubview(heading)
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(line3)
        view.addSubview(job1Button)
        view.addSubview(job2Button)
        view.addSubview(job3Button)
        view.addSubview(job4Button)
        view.addSubview(job5Button)
        view.addSubview(addJobButton)
        view.addSubview(totalHoursButton)
        
        job1Button.addTarget(self, action: #selector(job1ButtonHit(_:)), for: .touchUpInside)
        job2Button.addTarget(self, action: #selector(job2ButtonHit(_:)), for: .touchUpInside)
        job3Button.addTarget(self, action: #selector(job3ButtonHit(_:)), for: .touchUpInside)
        job4Button.addTarget(self, action: #selector(job4ButtonHit(_:)), for: .touchUpInside)
        job5Button.addTarget(self, action: #selector(job5ButtonHit(_:)), for: .touchUpInside)
        addJobButton.addTarget(self, action: #selector(addJobHit(_:)), for: .touchUpInside)
        totalHoursButton.addTarget(self, action: #selector(viewTotalHours(_:)), for: .touchUpInside)
        
        checkButtons() // show used buttons
        setButtonTitles() // name buttons
        
    }
    
    override func viewDidLayoutSubviews() {
        heading.frame = CGRect(x: 30, y: 130, width: 315, height: 50)
        line1.frame = CGRect(x: 0, y: 100, width: screen.width, height: 2)
        line2.frame = CGRect(x: 0, y: 605, width: screen.width, height: 2)
        line3.frame = CGRect(x: 0, y: 770, width: screen.width, height: 2)
        
        job1Button.frame = CGRect(x: 30, y: 220, width: 315, height: 50)
        job2Button.frame = CGRect(x: 30, y: 290, width: 315, height: 50)
        job3Button.frame = CGRect(x: 30, y: 360, width: 315, height: 50)
        job4Button.frame = CGRect(x: 30, y: 430, width: 315, height: 50)
        job5Button.frame = CGRect(x: 30, y: 500, width: 315, height: 50)
        totalHoursButton.frame = CGRect(x: 30, y: 630, width: 315, height: 50)
        addJobButton.frame = CGRect(x: 30, y: 700, width: 315, height: 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let infoButton = jf.createBarButton(image: infoImage, target: self, action: #selector(goToHelpCenter(_:)))
        let settingsButton = jf.createBarButton(image: settingsImage, target: self, action: #selector(goToSettings(_:)))
        let resetButton = jf.createBarButton(image: resetImage, target: self, action: #selector(resetHours(_:)))
        let saveButton = jf.createBarButton(image: saveImage, target: self, action: #selector(savePDF(_:)))
        
        
        self.navigationController?.navigationBar.backgroundColor = .basic
        self.navigationItem.rightBarButtonItems = [infoButton, settingsButton, resetButton, saveButton]
        
        checkButtons() // show used buttons
        setButtonTitles() // name buttons
        
        let today = Date()
        if Date().dayNumberOfWeek() == 2 {
            let date = Date.startOfDay(today)
            let timer = Timer(fireAt: date(),
                              interval: 0,
                              target: self,
                              selector: #selector(jf.clearHours as () -> Void),
                              userInfo: nil,
                              repeats: false)
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    /* display button functions */
    func checkButtons() { // show used buttons
        jf.modifyBool(array: &tmpBool)
        job1Button.isHidden = tmpBool[0]
        job2Button.isHidden = tmpBool[1]
        job3Button.isHidden = tmpBool[2]
        job4Button.isHidden = tmpBool[3]
        job5Button.isHidden = tmpBool[4]
    }
    
    func setButtonTitles(){ // set button names
        jf.modify(array: &tmpString)
        do {
            jobPositionsModels = try context.fetch(JobPositions.fetchRequest())
            for info in jobPositionsModels {
                job1Button.setTitle(info.job1name, for: .normal)
                job2Button.setTitle(info.job2name, for: .normal)
                job3Button.setTitle(info.job3name, for: .normal)
                job4Button.setTitle(info.job4name, for: .normal)
                job5Button.setTitle(info.job5name, for: .normal)
            }
        }
        catch {
            // error
        }
    }
    
    /* job button functions */
    @objc func job1ButtonHit(_ sender: UIButton!) {
        sendJobNumber = 1
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton1))
        job1Button.addGestureRecognizer(tapPress)
        job1Button.addGestureRecognizer(longPress)
    }
    
    @objc func job2ButtonHit(_ sender: Any) {
        sendJobNumber = 2
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton2))
        job2Button.addGestureRecognizer(tapPress)
        job2Button.addGestureRecognizer(longPress)
    }
    
    @objc func job3ButtonHit(_ sender: Any) {
        sendJobNumber = 3
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton3))
        job3Button.addGestureRecognizer(tapPress)
        job3Button.addGestureRecognizer(longPress)
    }
    
    @objc func job4ButtonHit(_ sender: Any) {
        sendJobNumber = 4
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton4))
        job4Button.addGestureRecognizer(tapPress)
        job4Button.addGestureRecognizer(longPress)
    }
    
    @objc func job5ButtonHit(_ sender: Any) {
        sendJobNumber = 5
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton5))
        job5Button.addGestureRecognizer(tapPress)
        job5Button.addGestureRecognizer(longPress)
    }
    
    @objc func goToTimer() {
        performSegue(withIdentifier: "goToTimer", sender: self)
    }
    
    /* delete button functions */
    @objc func deleteButton1() {
        jf.modifyBool(array: &tmpBool)
        if tmpBool[1] == false {
            jf.modify2Hours(array: &jf.tmp2Hours)
            jf.save1HoursFromTmp(array: &jf.tmp2Hours)
        }
        if tmpBool[2] == false {
            jf.modify3Hours(array: &jf.tmp3Hours)
            jf.save2HoursFromTmp(array: &jf.tmp3Hours)
        }
        if tmpBool[3] == false {
            jf.modify4Hours(array: &jf.tmp4Hours)
            jf.save3HoursFromTmp(array: &jf.tmp4Hours)
        }
        if tmpBool[4] == false {
            jf.modify5Hours(array: &jf.tmp5Hours)
            jf.save4HoursFromTmp(array: &jf.tmp5Hours)
        }
        jf.save5HoursFromTmp(array: &jf.clearAll)
        showDeleteAction(i: 0)
    }
    
    @objc func deleteButton2() {
        if tmpBool[2] == false {
            jf.modify3Hours(array: &jf.tmp3Hours)
            jf.save2HoursFromTmp(array: &jf.tmp3Hours)
        }
        if tmpBool[3] == false {
            jf.modify4Hours(array: &jf.tmp4Hours)
            jf.save3HoursFromTmp(array: &jf.tmp4Hours)
        }
        if tmpBool[4] == false {
            jf.modify5Hours(array: &jf.tmp5Hours)
            jf.save4HoursFromTmp(array: &jf.tmp5Hours)
        }
        jf.save5HoursFromTmp(array: &jf.clearAll)
        showDeleteAction(i: 1)
    }
    
    @objc func deleteButton3() {
        if tmpBool[3] == false {
            jf.modify4Hours(array: &jf.tmp4Hours)
            jf.save3HoursFromTmp(array: &jf.tmp4Hours)
        }
        if tmpBool[4] == false {
            jf.modify5Hours(array: &jf.tmp5Hours)
            jf.save4HoursFromTmp(array: &jf.tmp5Hours)
        }
        jf.save5HoursFromTmp(array: &jf.clearAll)
        showDeleteAction(i: 2)
    }
    
    @objc func deleteButton4() {
        if tmpBool[4] == false {
            jf.modify5Hours(array: &jf.tmp5Hours)
            jf.save4HoursFromTmp(array: &jf.tmp5Hours)
        }
        jf.save5HoursFromTmp(array: &jf.clearAll)
        showDeleteAction(i: 3)
    }
    
    @objc func deleteButton5() {
        jf.save5HoursFromTmp(array: &jf.clearAll)
        showDeleteAction(i: 4)
    }
    
    func showDeleteAction(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i)
        }))
        
        present(sheet, animated: true)
    }
    
    func removeButton(index: Int) { // delete button
        jf.modify(array: &tmpString)
        jf.modifyPay(array: &tmpDouble)
        jf.modifyBool(array: &tmpBool)
        if index != 4 {
            for j in index...3 {
                tmpString[j] = tmpString[j + 1]
                tmpDouble[j] = tmpDouble[j + 1]
            }
            
            let index = tmpBool.firstIndex(of: true)
            tmpBool[(index ?? 5) - 1] = true
            switch (index ?? 5) - 1 {
            case 0:
                jf.save1HoursFromTmp(array: &jf.clearAll)
            case 1:
                jf.save2HoursFromTmp(array: &jf.clearAll)
            case 2:
                jf.save3HoursFromTmp(array: &jf.clearAll)
            case 3:
                jf.save4HoursFromTmp(array: &jf.clearAll)
            case 4:
                jf.save5HoursFromTmp(array: &jf.clearAll)
            default:
                fatalError()
            }
        } else {
            tmpBool[4] = true
        }
        tmpString[4] = ""
        tmpDouble[4] = 0.0
        
        jf.saveBoolFromTmp(array: &tmpBool)
        jf.saveNamesFromTmp(array: &tmpString)
        jf.savePayFromTmp(array: &tmpDouble)
        checkButtons()
        setButtonTitles()
    }
    
    @objc func addJobHit(_ sender: UIButton!) {
        if job5Button.isHidden == false {
            let alert = UIAlertController(title: "Job Limit Reached", message: "Delete a job option before adding a new job.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else {
            performSegue(withIdentifier: "goToAddJob", sender: self)
        }
    }
    
    /* Navigation Bar Functions */
    @objc func goToHelpCenter(_ sender: UIBarButtonItem!) {
        performSegue(withIdentifier: "goToHelpCenter", sender: self)
    }
    
    @objc func goToSettings(_ sender: UIBarButtonItem!) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    @objc func resetHours(_ sender: UIBarButtonItem!) { // reset hours on command
        let alert = UIAlertController(title: "Reset Hours?", message: "Are you sure you want to reset your hours?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.jf.clearHours()
        }))
        
        present(alert, animated: true)
    }
    
    /* Save to PDF Navigation Button functions */
    @objc func savePDF(_ sender: UIBarButtonItem!) {
        convertToPdfFileAndShare()
    }

    func convertToPdfFileAndShare(){
        jf.getRounding(Bool: &rounds)
        if rounds { pdfData = jf.createRoundedPDFString() }
        else { pdfData = jf.createUnroundedPDFString() }
        
        let htmlText = UIMarkupTextPrintFormatter(markupText: pdfData)
        
        // Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(htmlText, startingAtPageAt: 0)
        
        // Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        // Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        // Save PDF file
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Week Report").appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        
        pdfData.write(to: outputURL, atomically: true)
        print("open \(outputURL.path)")
        
        if FileManager.default.fileExists(atPath: outputURL.path){
            
            let url = URL(fileURLWithPath: outputURL.path)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            
            //If user on iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                if activityViewController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                }
            }
            present(activityViewController, animated: true, completion: nil)

        }
        else {
            print("document was not found")
        }
        
    }
    /* end PDF functions */
    
    /* TimerViewController Related Functions */
    func presentPage() {
        guard let first = myControllers.first else {
            return
        }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1
        return myControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else {
            return nil
        }
        let after = index + 1
        return myControllers[after]
    }
    
    @objc func viewTotalHours(_ sender: UIButton!) {
        jf.modify1Hours(array: &jf.tmp1Hours)
        jf.modify2Hours(array: &jf.tmp2Hours)
        jf.modify3Hours(array: &jf.tmp3Hours)
        jf.modify4Hours(array: &jf.tmp4Hours)
        jf.modify5Hours(array: &jf.tmp5Hours)
        jf.modifyBool(array: &tmpBool)
        jf.modifyPay(array: &tmpDouble)
        jf.modify(array: &tmpString)
        jf.getRounding(Bool: &rounds)
        
        if tmpBool.allSatisfy({ $0 == true }) {
            let alert = UIAlertController(title: "Missing Jobs", message: "Add a job option to see your total work hours.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
        var pages = [[String]]()
        myControllers.removeAll() // reset pages
        
        if tmpBool[0] == false {
            pages.append([tmpString[0], String(jf.tmp1Hours[0]), String(jf.tmp1Hours[1]), String(jf.tmp1Hours[2]), String(jf.tmp1Hours[3]), String(jf.tmp1Hours[4]), String(jf.tmp1Hours[5]), String(jf.tmp1Hours[6]), String(tmpDouble[0])])
        }
        if tmpBool[1] == false {
            pages.append([tmpString[1], String(jf.tmp2Hours[0]), String(jf.tmp2Hours[1]), String(jf.tmp2Hours[2]), String(jf.tmp2Hours[3]), String(jf.tmp2Hours[4]), String(jf.tmp2Hours[5]), String(jf.tmp2Hours[6]), String(tmpDouble[1])])
        }
        if tmpBool[2] == false {
            pages.append([tmpString[2], String(jf.tmp3Hours[0]), String(jf.tmp3Hours[1]), String(jf.tmp3Hours[2]), String(jf.tmp3Hours[3]), String(jf.tmp3Hours[4]), String(jf.tmp3Hours[5]), String(jf.tmp3Hours[6]), String(tmpDouble[2])])
        }
        if tmpBool[3] == false {
            pages.append([tmpString[3], String(jf.tmp4Hours[0]), String(jf.tmp4Hours[1]), String(jf.tmp4Hours[2]), String(jf.tmp4Hours[3]), String(jf.tmp4Hours[4]), String(jf.tmp4Hours[5]), String(jf.tmp4Hours[6]), String(tmpDouble[3])])
        }
        if tmpBool[4] == false {
            pages.append([tmpString[4], String(jf.tmp5Hours[0]), String(jf.tmp5Hours[1]), String(jf.tmp5Hours[2]), String(jf.tmp5Hours[3]), String(jf.tmp5Hours[4]), String(jf.tmp5Hours[5]), String(jf.tmp5Hours[6]), String(tmpDouble[4])])
        }
        
        for row in pages {
            var sum = 0.0
            for i in 1...7 {
                if rounds { sum += ((Double(row[i]) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero) }
                else { sum += (Double(row[i]) ?? 0.0) / 60 }
            }
            if rounds { sum = round(sum) * (Double(row[8]) ?? 0.0) }
            else { sum *= (Double(row[8]) ?? 0.0) }
            let vc = TotalHoursViewController(with: row[0], with: row[2], with: row[3], with: row[4], with: row[5], with: row[6], with: row[7], with: row[1], with: String(sum), with: rounds)
            myControllers.append(vc)
        }
        
        self.presentPage()
    }
    /* end total pages */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let timerVC = segue.destination as? TimerViewController {
            timerVC.jobNumber = self.sendJobNumber
        }
    }
}

extension UIColor {
    static let basic = UIColor(named: "basicBackground")
    static let nonBasic = UIColor(named: "basicInverted")
    static let customTeal = UIColor(named: "primaryTeal")
    static let customPurple = UIColor(named: "primaryPurple")
    static let customPurple2 = UIColor(named: "backgroundPurple")
    static let blueButton = UIColor(named: "buttonBlue")
    static let tealButton = UIColor(named: "buttonTeal")
    static let border = UIColor(named: "borderGray")
    static let arrow = UIColor(named: "arrowGray")
}
