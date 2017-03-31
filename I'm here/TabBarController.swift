//
//  TabBarController.swift
//  Im here
//
//  Created by Victor Presumido on 3/30/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import UIKit
import SwipeableTabBarController

class TabBarController: SwipeableTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedViewController = viewControllers?[0]
        setSwipeAnimation(type: SwipeAnimationType.sideBySide)
    }
}
