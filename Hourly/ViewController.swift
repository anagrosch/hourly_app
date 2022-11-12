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

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    /* var for totals page */
    var myControllers = [UIViewController]()
    
    /* Core Data intializations */
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var hideButtonModels = [HideButtons]()
    private var jobPositionsModels = [JobPositions]()
    private var jobPayModels = [JobWages]()
    private var job1Models = [Job1Info]()
    private var job2Models = [Job2Info]()
    private var job3Models = [Job3Info]()
    private var job4Models = [Job4Info]()
    private var job5Models = [Job5Info]()
    var tmpDouble = [0.0, 0.0, 0.0, 0.0, 0.0]
    var tmpString = ["", "", "", "", ""]
    var tmpBool = [true, true, true, true, true]
    var sendJobNumber = 0

    var tmp1Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp2Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp3Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp4Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var tmp5Hours: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    var clearAll: [Int16] = [0, 0, 0, 0, 0, 0, 0]
    
    @IBOutlet weak var job1Button: UIButton!
    @IBOutlet weak var job2Button: UIButton!
    @IBOutlet weak var job3Button: UIButton!
    @IBOutlet weak var job4Button: UIButton!
    @IBOutlet weak var job5Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButtons() // show used buttons
        setButtonTitles() // name buttons
        
        let today = Date()
        if Date().dayNumberOfWeek() == 2 {
            let date = Date.startOfDay(today)
            let timer = Timer(fireAt: date(),
                              interval: 0,
                              target: self,
                              selector: #selector(clearHours as () -> Void),
                              userInfo: nil,
                              repeats: false)
            RunLoop.main.add(timer, forMode: .common)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .black
    }
    
    /* get info from Core Data functions */
    func modifyBool(array: inout [Bool]) { //get if buttons are hidden
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
    
    /* display button functions */
    func checkButtons() { // show used buttons
        modifyBool(array: &tmpBool)
        job1Button.isHidden = tmpBool[0]
        job2Button.isHidden = tmpBool[1]
        job3Button.isHidden = tmpBool[2]
        job4Button.isHidden = tmpBool[3]
        job5Button.isHidden = tmpBool[4]
    }
    
    func setButtonTitles(){ // set button names
        modify(array: &tmpString)
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
    
    @IBAction func addJobButton(_ sender: Any) {
        if job5Button.isHidden == false {
            let alert = UIAlertController(title: "Job Limit Reached", message: "Delete at job option before adding a new job.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else {
            performSegue(withIdentifier: "goToAddJob", sender: self)
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
        modifyBool(array: &tmpBool)
        if tmpBool[1] == false {
            modify2Hours(array: &tmp2Hours)
            save1HoursFromTmp(array: &tmp2Hours)
        }
        if tmpBool[2] == false {
            modify3Hours(array: &tmp3Hours)
            save2HoursFromTmp(array: &tmp3Hours)
        }
        if tmpBool[3] == false {
            modify4Hours(array: &tmp4Hours)
            save3HoursFromTmp(array: &tmp4Hours)
        }
        if tmpBool[4] == false {
            modify5Hours(array: &tmp5Hours)
            save4HoursFromTmp(array: &tmp5Hours)
        }
        save5HoursFromTmp(array: &clearAll)
        showDelete1Action(i: 0)
    }
    
    @objc func deleteButton2() {
        if tmpBool[2] == false {
            modify3Hours(array: &tmp3Hours)
            save2HoursFromTmp(array: &tmp3Hours)
        }
        if tmpBool[3] == false {
            modify4Hours(array: &tmp4Hours)
            save3HoursFromTmp(array: &tmp4Hours)
        }
        if tmpBool[4] == false {
            modify5Hours(array: &tmp5Hours)
            save4HoursFromTmp(array: &tmp5Hours)
        }
        save5HoursFromTmp(array: &clearAll)
        showDelete2Action(i: 1)
    }
    
    @objc func deleteButton3() {
        if tmpBool[3] == false {
            modify4Hours(array: &tmp4Hours)
            save3HoursFromTmp(array: &tmp4Hours)
        }
        if tmpBool[4] == false {
            modify5Hours(array: &tmp5Hours)
            save4HoursFromTmp(array: &tmp5Hours)
        }
        save5HoursFromTmp(array: &clearAll)
        showDelete3Action(i: 2)
    }
    
    @objc func deleteButton4() {
        if tmpBool[4] == false {
            modify5Hours(array: &tmp5Hours)
            save4HoursFromTmp(array: &tmp5Hours)
        }
        save5HoursFromTmp(array: &clearAll)
        showDelete4Action(i: 3)
    }
    
    @objc func deleteButton5() {
        save5HoursFromTmp(array: &clearAll)
        showDelete5Action(i: 4)
    }
    
    func showDelete1Action(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i, array: &self.tmp1Hours)
        }))
        
        present(sheet, animated: true)
    }
    
    func showDelete2Action(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i, array: &self.tmp2Hours)
        }))
        
        present(sheet, animated: true)
    }
    
    func showDelete3Action(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i, array: &self.tmp3Hours)
        }))
        
        present(sheet, animated: true)
    }
    
    func showDelete4Action(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i, array: &self.tmp4Hours)
        }))
        
        present(sheet, animated: true)
    }
    
    func showDelete5Action(i: Int) { // delete button alert
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.removeButton(index: i, array: &self.tmp5Hours)
        }))
        
        present(sheet, animated: true)
    }
    
    func removeButton(index: Int, array: inout [Int16]) { // delete button
        modify(array: &tmpString)
        modifyPay(array: &tmpDouble)
        modifyBool(array: &tmpBool)
        if index != 4 {
            for j in index...3 {
                tmpString[j] = tmpString[j + 1]
                tmpDouble[j] = tmpDouble[j + 1]
            }
            
            let index = tmpBool.firstIndex(of: true)
            tmpBool[(index ?? 5) - 1] = true
            switch (index ?? 5) - 1 {
            case 0:
                save1HoursFromTmp(array: &clearAll)
            case 1:
                save2HoursFromTmp(array: &clearAll)
            case 2:
                save3HoursFromTmp(array: &clearAll)
            case 3:
                save4HoursFromTmp(array: &clearAll)
            case 4:
                save5HoursFromTmp(array: &clearAll)
            default:
                fatalError()
            }
        } else {
            tmpBool[4] = true
        }
        tmpString[4] = ""
        tmpDouble[4] = 0.0
        
        saveBoolFromTmp(array: &tmpBool)
        saveNamesFromTmp(array: &tmpString)
        savePayFromTmp(array: &tmpDouble)
        checkButtons()
        setButtonTitles()
    }
    
    func clearHours(array: inout [Int16]) {
        for i in 0...6 {
            array[i] = 0
        }
    }
    
    /* TimerViewController Related Functions */
    @objc func clearHours() {
        save1HoursFromTmp(array: &clearAll)
        save2HoursFromTmp(array: &clearAll)
        save3HoursFromTmp(array: &clearAll)
        save4HoursFromTmp(array: &clearAll)
        save5HoursFromTmp(array: &clearAll)
    }
    
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
            self.clearHours()
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func viewTotalHours(_ sender: Any) {
        modify1Hours(array: &tmp1Hours)
        modify2Hours(array: &tmp2Hours)
        modify3Hours(array: &tmp3Hours)
        modify4Hours(array: &tmp4Hours)
        modify5Hours(array: &tmp5Hours)
        modifyBool(array: &tmpBool)
        modifyPay(array: &tmpDouble)
        modify(array: &tmpString)
        
        if tmpBool.dropFirst().allSatisfy({ $0 == tmpBool.first }) {
            let alert = UIAlertController(title: "Missing Jobs", message: "Add a job option to see your total work hours.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        
        var pages = [[String]]()
        myControllers.removeAll() // reset pages
        
        if tmpBool[0] == false {
            pages.append([tmpString[0], String(tmp1Hours[0]), String(tmp1Hours[1]), String(tmp1Hours[2]), String(tmp1Hours[3]), String(tmp1Hours[4]), String(tmp1Hours[5]), String(tmp1Hours[6]), String(tmpDouble[0])])
        }
        if tmpBool[1] == false {
            pages.append([tmpString[1], String(tmp2Hours[0]), String(tmp2Hours[1]), String(tmp2Hours[2]), String(tmp2Hours[3]), String(tmp2Hours[4]), String(tmp2Hours[5]), String(tmp2Hours[6]), String(tmpDouble[1])])
        }
        if tmpBool[2] == false {
            pages.append([tmpString[2], String(tmp3Hours[0]), String(tmp3Hours[1]), String(tmp3Hours[2]), String(tmp3Hours[3]), String(tmp3Hours[4]), String(tmp3Hours[5]), String(tmp3Hours[6]), String(tmpDouble[2])])
        }
        if tmpBool[3] == false {
            pages.append([tmpString[3], String(tmp4Hours[0]), String(tmp4Hours[1]), String(tmp4Hours[2]), String(tmp4Hours[3]), String(tmp4Hours[4]), String(tmp4Hours[5]), String(tmp4Hours[6]), String(tmpDouble[3])])
        }
        if tmpBool[4] == false {
            pages.append([tmpString[4], String(tmp5Hours[0]), String(tmp5Hours[1]), String(tmp5Hours[2]), String(tmp5Hours[3]), String(tmp5Hours[4]), String(tmp5Hours[5]), String(tmp5Hours[6]), String(tmpDouble[4])])
        }
        
        for row in pages {
            var sum = 0.0
            for i in 1...7 {
                sum += ((Double(row[i]) ?? 0.0) / 60).rounded(.toNearestOrAwayFromZero)
            }
            sum = round(sum) * (Double(row[8]) ?? 0.0)
            let vc = TotalHoursViewController(with: row[0], with: row[1], with: row[2], with: row[3], with: row[4], with: row[5], with: row[6], with: row[7], with: String(sum))
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

