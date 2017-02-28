//
//  FirstViewController.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{
  
  let clock = Clock()
  var timer: Timer?
  @IBOutlet weak var timeLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FirstViewController.updateTimeLabel), userInfo: nil, repeats: true)
   }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateTimeLabel()
  }
  
  deinit {
    timer?.invalidate()
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
  func updateTimeLabel(){
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let time = formatter.string(from: clock.currentTime as Date)
    timeLabel.text = "\(time)"
  }
  
  func blinkColon() -> String{
    var formatter = DateFormatter()
    formatter.timeStyle = .short
    var time = formatter.string(from: clock.currentTime as Date)

    formatter.dateFormat = "ss"
    let seconds = Int(formatter.string(from: clock.currentTime as Date))
    if(seconds! % 2 == 0){
      
     time = time.replacingOccurrences(of: ":", with: " ")
    }
    return time
  }
}

