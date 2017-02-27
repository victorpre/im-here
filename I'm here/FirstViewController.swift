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
  
  @IBOutlet weak var timeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let formattedTime = formatter.string(from: clock.currentTime as Date)
    timeLabel.text = "\(formattedTime)"
    
   }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
  
}

