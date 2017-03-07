//
//  FirstViewController.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
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
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FirstViewController.updateTimeLabel), userInfo: nil, repeats: true)
   }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateTimeLabel()
    print(myPunches.count)
    shifts.drop()
  }
  
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
    shifts.add(time: clock.currentTime)
    updateTableView()
  }
  
  func updateTableView() {
    myPunches = shifts.punches()
    tableView.reloadData()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myPunches.count
  }
  
  func getTimeDiff(arrivalDate: NSDate, leavingDate: NSDate){
    var timeDiff = leavingDate.compare(arrivalDate as Date)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let punch = myPunches[indexPath.row]
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm 'on' dd/MM/yyyy"
    var time = formatter.string(from: punch as! Date)
    if(indexPath.row % 2 == 0){
      cell.textLabel?.text = "Started at \(time)"
    }else{
      cell.textLabel?.text = "Ended at \(time)"
    }
    
    
    return cell
  }
}





