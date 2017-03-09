//
//  Clock.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import Foundation
import SwiftDate

class Clock{
    
    var currentTime: NSDate{
        return NSDate()
    }
    
    func timeDiffInSeconds(arrivalDate: NSDate, leavingDate: NSDate)->Int{
        let timeDiff = leavingDate.timeIntervalSince(arrivalDate as Date)
        return Int(timeDiff.rounded(.towardZero))
    }
    
//    func hoursWorked(arrivalDate: NSDate, leavingDate: NSDate)->Double{
//        let seconds = self.timeDiffInSeconds(arrivalDate: arrivalDate, leavingDate: leavingDate)
//        var hoursStr = (seconds/60)
//        if (seconds >= 3600){
//            hoursStr = (seconds/3600)
//        }
//        return Double(hoursStr)
//    }
    
    func workedSeconds(dates: Array<NSDate>)->Double{
        var seconds = 0.0
        let maxIndex = (dates.count % 2 == 0) ? dates.count : dates.count-1
        for index in stride(from: 0,to: maxIndex, by: 2) {
            seconds = seconds + Double(self.timeDiffInSeconds(arrivalDate: dates[index+1], leavingDate: dates[index]))
        }
        return seconds * -1.0
    }
}
