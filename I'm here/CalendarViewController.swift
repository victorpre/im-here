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
        
        let tableViewContainerView = UITableView(frame: CGRect(x: 0, y: calendar.fs_bottom + 20, width: self.view.bounds.width, height: self.view.fs_height - height - 20))
        tableViewContainerView.backgroundColor = UIColor.white
        
        
        self.view.addSubview(tableViewContainerView)
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Calendar"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        print(date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = "Yolo"
        
        return cell
    }

    
}
