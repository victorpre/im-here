//
//  FirstViewController.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import UIKit

class PunchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
  let clock = Clock()
  var timer: Timer?
  let shifts = Shifts()
  var myPunches : [NSDate] = []
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var timeWorkedToday: UILabel!
  
  //  Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PunchViewController.updateTimeLabel), userInfo: nil, repeats: true)


   }
  

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    shifts.drop()
    print(shifts.all().count)
    updateHoursWorkedLabel()
    updateTimeLabel()
    
  }
  
//  func populateHours() -> Array<NSDate> {
//    return [NSDate(),NSDate().addingTimeInterval(3600),NSDate().addingTimeInterval(7200),NSDate().addingTimeInterval(10800),NSDate().addingTimeInterval(14400),NSDate().addingTimeInterval(16200)]
//  }
  //Timer
  deinit {
    timer?.invalidate()
  }
  
  func updateTimeLabel(){
    timeLabel.text = "\(blinkColon())"
  }
  
  func blinkColon() -> String{
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    var time = formatter.string(from: clock.currentTime as Date)

    formatter.dateFormat = "ss"
    let seconds = Int(formatter.string(from: clock.currentTime as Date))
    if(seconds! % 2 != 0){
      
     time = time.replacingOccurrences(of: ":", with: " ")
    }
    return time
  }
  
  @IBAction func punch(_ sender: Any) {
    if (shifts.add(time: clock.currentTime)){
      updateHoursWorkedLabel()
      updateTableView()
    }
  }
  
  func updateHoursWorkedLabel(){
    let start = Date().startOfDay as NSDate
    let end = Date().endOfDay! as NSDate
    print (start)
    print (end)
    myPunches = shifts.punches(start: start, end: end)
    let time = clock.seconds2Timestamp(seconds: clock.workedSeconds(dates: myPunches))
    
    timeWorkedToday.text = "Time worked today: \(time)"
  }
  
  func updateTableView() {
    let start = Date().startOfDay as NSDate
    let end = Date().endOfDay! as NSDate
    print (start)
    print (end)
    myPunches = shifts.punches(start: start, end: end)
    tableView.reloadData()
    
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


