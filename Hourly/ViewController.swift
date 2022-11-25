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
    
    let jf = JobFunctions()
    
    var tmpString = ["", "", "", "", ""]
    var tmpDouble = [0.0, 0.0, 0.0, 0.0, 0.0]
    var tmpBool = [true, true, true, true, true]
    var sendJobNumber = 0
    var rounds = false
    var pdfData: String = ""
    
    @IBOutlet weak var job1Button: UIButton!
    @IBOutlet weak var job2Button: UIButton!
    @IBOutlet weak var job3Button: UIButton!
    @IBOutlet weak var job4Button: UIButton!
    @IBOutlet weak var job5Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButtons() // show used buttons
        setButtonTitles() // name buttons
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .black
        
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
    @IBAction func job1ButtonHit(_ sender: Any) {
        sendJobNumber = 1
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton1))
        job1Button.addGestureRecognizer(tapPress)
        job1Button.addGestureRecognizer(longPress)
    }
    
    @IBAction func job2ButtonHit(_ sender: Any) {
        sendJobNumber = 2
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton2))
        job2Button.addGestureRecognizer(tapPress)
        job2Button.addGestureRecognizer(longPress)
    }
    @IBAction func job3ButtonHit(_ sender: Any) {
        sendJobNumber = 3
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton3))
        job3Button.addGestureRecognizer(tapPress)
        job3Button.addGestureRecognizer(longPress)
    }
    @IBAction func job4ButtonHit(_ sender: Any) {
        sendJobNumber = 4
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(goToTimer))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteButton4))
        job4Button.addGestureRecognizer(tapPress)
        job4Button.addGestureRecognizer(longPress)
    }
    @IBAction func job5ButtonHit(_ sender: Any) {
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
    
    @IBAction func addJobButton(_ sender: Any) {
        if job5Button.isHidden == false {
            let alert = UIAlertController(title: "Job Limit Reached", message: "Delete a job option before adding a new job.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else {
            performSegue(withIdentifier: "goToAddJob", sender: self)
        }
    }
    
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
    
    @IBAction func resetHours(_ sender: Any) { // reset hours on command
        let alert = UIAlertController(title: "Reset Hours?", message: "Are you sure you want to reset your hours?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.jf.clearHours()
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func viewTotalHours(_ sender: Any) {
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
    
    /* Save to PDF Navigation Button functions */
    @IBAction func savePDF(_ sender: Any) {
        convertToPdfFileAndShare()
    }

    func convertToPdfFileAndShare(){
        jf.getRounding(Bool: &rounds)
        if rounds { pdfData = jf.createRoundedPDFString() }
        else { pdfData = jf.createUnroundedPDFString() }
        
        let fmt = UIMarkupTextPrintFormatter(markupText: pdfData)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let timerVC = segue.destination as? TimerViewController {
            timerVC.jobNumber = self.sendJobNumber
        }
    }
}

