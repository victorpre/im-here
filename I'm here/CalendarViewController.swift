//
//  SecondViewController.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate {
    
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    let shifts = Shifts()
    var myPunches : [NSDate] = []
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 20, width: self.view.bounds.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        self.view.addSubview(calendar)
        self.calendar = calendar
        
        let tableView = UITableView(frame: CGRect(x: 0, y: calendar.fs_bottom + 20, width: self.view.bounds.width, height: self.view.fs_height - height - 20))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Calendário"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView(date: Date())
    }
    
    func updateTableView(date: Date) {
        let start = date.startOfDay  as NSDate
        let end =  date.endOfDay! as NSDate
        myPunches = shifts.punches(start: start, end: end)
        tableView.reloadData()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        print(date)
        updateTableView(date: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPunches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let punch = myPunches[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm 'on' dd/MM/yyyy"
        let time = formatter.string(from: punch as Date)
        if(myPunches.count % 2 == 0){
            if(indexPath.row % 2 == 0){
                cell.textLabel?.text = "Ended at \(time)"
                
            }else{
                cell.textLabel?.text = "Started at \(time)"
            }
        }else{
            if(indexPath.row % 2 == 0){
                cell.textLabel?.text = "Started at \(time)"
            }else{
                cell.textLabel?.text = "Ended at \(time)"
            }
        }
        
        return cell
    }
}
