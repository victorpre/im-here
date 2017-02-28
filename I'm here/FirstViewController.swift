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
  var myShifts : [Shift] = []
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
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
    print(myShifts.count)
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
    myShifts = shifts.all()
    tableView.reloadData()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myShifts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let shift = myShifts[indexPath.row]
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm 'at' dd/MM/yyyy"
    var time = formatter.string(from: shift.beginTime as! Date)
    cell.textLabel?.text = "Started at \(time)"
    
    return cell
  }
}





